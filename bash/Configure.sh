#!/bin/bash
<<COMMENT
The first-level cloud migration automatically modifies the relevant configuration file scripts, and completes the relevant work in the form of functions.
>> Author: Alex Fan
>> Date Created: 2022-07-06-09:58
>> Email: fansihong02@gmail.com
>> Shell: bash
>> CopyRight: Alex Fan
COMMENT
source CommonColor.sh # Include public color script
TARGET=$1

# Delete directories without planes after renaming
function renamingPlane(){
  set -eu
  h1RedUndFont "Delete directories without planes after renaming\t\t\t"
  echo
  ls $TARGET|while read directory;
  do
    if [[ $(echo $directory|grep -o sandun) == sandun ]];then
      whiteFont "Renaming ${directory} to ${directory%*sandun}RUN_ZD_BCORE_PLANE"
      mv ${TARGET}/${directory} ${TARGET}/${directory%*sandun}RUN_ZD_BCORE_PLANE
    elif [[ $(echo $directory|grep -o shiqiao) == shiqiao ]];then
      whiteFont "Renaming ${directory} to ${directory%*shiqiao}RUN_HZW_BCORE_PLANE"
      mv ${TARGET}/${directory} ${TARGET}/${directory%*shiqiao}RUN_HZW_BCORE_PLANE
    elif [[ $(echo $directory|grep -o hd) == hd ]];then
      whiteFont "Renaming ${directory} to ${directory%*hd}RUN_ZD_B0DOT1_PLANE"
      mv ${TARGET}/${directory} ${TARGET}/${directory%*hd}RUN_ZD_B0DOT1_PLANE
    else
      echo "${directory}"
    fi
  done
  echo
  h1RedUndFont "The following directories without planes will be deleted"
  ls $TARGET | grep -Ev "RUN_ZD_BCORE_PLANE|RUN_HZW_BCORE_PLANE|RUN_ZD_B0DOT1_PLANE"|while read dir;
  do
    echo $dir
    rm -rf ${TARGET}/${dir}
  done
  echo
}

# Modify the csf.xml configuration file
function csfModify(){
  set -eu
  find $TARGET -name csf.xml|while read csf;                           
  do                                                                   
    if [[ $(sed -n '/<tenant>.*<\/tenant>/p' $csf|wc -l) -eq 0 ]];then 
      cp -f $(dirname $0)/csf-transform-xml.jar ${csf%/*}              
      if [[ -f ${csf%/*}/csf-transform-xml.jar ]];then                 
        cd ${csf%/*};java -jar csf-transform-xml.jar csf.xml           
        if [[ -f csf-3.2.xml ]];then                                   
          mv csf-3.2.xml csf.xml                                       
        else                                                           
          redBoldFont "csf-3.2.xml not found"                          
          exit 21                                                      
        fi                                                             
      else                                                             
        redBoldFont "csf-transform-xml.jar not found"                  
        exit 22                                                        
      fi                                                               
    fi                                                                 
  done                                                                 
  find $TARGET -name csf.xml|while read csf; # csf.xml租户修改
  do                                                                       
    sed -i "" 's/<tenant>.*<\/tenant>/<tenant>TN_ZJ_ITOMD<\/tenant>/' $csf 
  done                                                                     
  
  find $TARGET -name csf.xml|grep 'resources-csf'|while read csf; # csf模块<Uds/>
  do                                                                       
    sed -i "" '/<\/Monitor>/r csf-uds.xml' $csf                            
  done                                                                     

  find $TARGET -name csf.xml|grep 'RUN_ZD_BCORE_PLANE'|while read zd; # ZK 浙东平面
  do                                                                       
    sed -i "" '/<NameServer:zk>/,/<\/NameServer:zk>/d' $zd                 
    sed -i "" '/<\/ProcInfo>/r RUN_ZD_BCORE_PLANE-csf-zk.xml' $zd          
  done                                                                     

  find $TARGET -name csf.xml|grep 'RUN_HZW_BCORE_PLANE'|while read hzw; # ZK 杭州湾 
  do                                                                       
    sed -i "" '/<NameServer:zk>/,/<\/NameServer:zk>/d' $hzw                
    sed -i "" '/<\/ProcInfo>/r RUN_HZW_BCORE_PLANE-csf-zk.xml' $hzw        
  done                                                                     

  find $TARGET -name csf.xml|grep 'RUN_ZD_B0DOT1_PLANE'|while read hd; # ZK 浙东灰度
  do                                                                       
    sed -i "" '/<NameServer:zk>/,/<\/NameServer:zk>/d' $hd                 
    sed -i "" '/<\/ProcInfo>/r RUN_ZD_B0DOT1_PLANE-csf-zk.xml' $hd         
  done                                                                    
# 配置文件修改结果
  h1YellowUndFont "租户修改结果:\t\t\t"
  find $TARGET -name csf.xml|while read line;
  do
    echo $line
    greenFont $(sed -n '/<tenant>.*<\/tenant>/p' $line)
  done
  echo
  h1YellowUndFont "csf模块Common节点新增<Uds/>\t\t\t"
  find $TARGET -name csf.xml|grep 'resources-csf'|while read line;
  do
    echo $line
    greenFont $(sed -n '/<Uds\/>/p' $line)
  done
  echo
  h1YellowUndFont "浙东ZK\t\t\t"
  find $TARGET -name csf.xml|grep 'RUN_ZD_BCORE_PLANE'|while read line;
  do
    echo $line
    greenFont "$(sed -n '/<NameServer:zk>/,/<\/NameServer:zk>/p' $line)"
  done
  echo
  h1YellowUndFont "杭州湾ZK\t\t\t"
  find $TARGET -name csf.xml|grep 'RUN_HZW_BCORE_PLANE'|while read line;
  do
    echo $line
    greenFont "$(sed -n '/<NameServer:zk>/,/<\/NameServer:zk>/p' $line)"
  done
  echo 
  h1YellowUndFont "浙东灰度ZK\t\t\t"
  find $TARGET -name csf.xml|grep 'RUN_ZD_B0DOT1_PLANE'|while read line;
  do
    echo $line
    greenFont "$(sed -n '/<NameServer:zk>/,/<\/NameServer:zk>/p' $line)"
  done
}                                                                          

# CSF模块cache.xml新增大区路由缓存项 
function csfCache(){
  echo
  h1RedUndFont "CSF模块cache.xml新增大区路由缓存项\t\t\t"
  find $TARGET -name cache.xml|grep 'resources-csf'|while read cache;
  do
    if [[ $(sed -n '/<cache source="aicache" dataType="COMMON" id="com.ai.appframe2.complex.cache.impl.ServiceZoneCacheImpl" init="true"\/>/p' $cache|wc -l) -ne 0 ]];then
      echo $cache
      greenFont '<!--地市大区路由缓存--> already Add Nothing to do !'
    else
      sed -i "" '/<\/quartz>/r csf-route.xml' $cache
      echo $cache
      greenFont "$(sed -n '/<cache source="aicache" dataType="COMMON" id="com.ai.appframe2.complex.cache.impl.ServiceZoneCacheImpl" init="true"\/>/p' $cache)"
    fi
  done
}

# CACHE\CSF\MSG\EXE 要新增logback.xml
function addLogback(){
  echo
  h1RedUndFont "cache csf msg exe 模块新增 logback.xml\t\t\t"
  for module in `ls $TARGET|grep -E 'cache|exe|msg|csf'`
  do
    echo "[ Copy $(dirname $0)/logback.xml ] to [ $TARGET/$module ]"
    cp -f $(dirname $0)/logback.xml $TARGET/$module
    if [[ $? -eq 0 ]];then
      greenFont $(ls $TARGET/$module|grep 'logback.xml')
    else
      echo "Copy Failed !!!"
      exit 25
    fi
  done
}

# Modify the CacheConfig.xml file
function cacheConfig(){
  find $TARGET -name CacheConfig.xml|grep 'RUN_ZD_BCORE_PLANE'|while read zd; ## 浙东缓存ZK,redis
  do
    sed -i "" '/ConfigItem name="zkServerList".*<\/ConfigItem>$/d' $zd
    sed -i "" '/<ConfigKind name="zk">/r RUN_ZD_BCORE_PLANE-cacheConfig-zk.xml' $zd
    sed -i "" '/<server server_code="M".*\/>$/d' $zd
    sed -i "" '/<cache_servers>/r RUN_ZD_BCORE_PLANE-cacheConfig-redis.xml' $zd
    sed -i "" '/<server server_code="PceRedisCache" .*belong_group="redis_group[0-9].*\/>$/d' $zd
    sed -i "" '/<cache_servers>/r RUN_ZD_BCORE_PLANE-cacheConfig-product.xml' $zd
  done
  find $TARGET -name CacheConfig.xml|grep 'RUN_HZW_BCORE_PLANE'|while read hzw;## 杭州湾缓存ZK,redis
  do
    sed -i "" '/ConfigItem name="zkServerList".*<\/ConfigItem>$/d' $hzw
    sed -i "" '/<ConfigKind name="zk">/r RUN_HZW_BCORE_PLANE-cacheConfig-zk.xml' $hzw
    sed -i "" '/<server server_code="M".*\/>$/d' $hzw
    sed -i "" '/<cache_servers>/r RUN_HZW_BCORE_PLANE-cacheConfig-redis.xml' $hzw
    sed -i "" '/<server server_code="PceRedisCache" .*belong_group="redis_group[0-9].*\/>$/d' $hzw
    sed -i "" '/<cache_servers>/r RUN_HZW_BCORE_PLANE-cacheConfig-product.xml' $hzw
  done
  find $TARGET -name CacheConfig.xml|grep 'RUN_ZD_B0DOT1_PLANE'|while read zdhd;## 浙东灰度ZK,redis
  do
    sed -i "" '/ConfigItem name="zkServerList".*<\/ConfigItem>$/d' $zdhd
    sed -i "" '/<ConfigKind name="zk">/r RUN_ZD_B0DOT1_PLANE-cacheConfig-zk.xml' $zdhd
    sed -i "" '/<server server_code="M".*\/>$/d' $zdhd
    sed -i "" '/<cache_servers>/r RUN_ZD_B0DOT1_PLANE-cacheConfig-redis.xml' $zdhd
    sed -i "" '/<server server_code="PceRedisCache" .*belong_group="redis_group[0-9].*\/>$/d' $zdhd
    sed -i "" '/<cache_servers>/r RUN_ZD_B0DOT1_PLANE-cacheConfig-product.xml' $zdhd
  done

  h1RedUndFont "浙东ZK修改结果:\t\t\t"
  find $TARGET -name CacheConfig.xml|grep RUN_ZD_BCORE_PLANE|while read ret;
  do
    echo $ret
    greenFont "$(sed -n '/ConfigItem name="zkServerList".*<\/ConfigItem>$/p' $ret)"
    echo
  done
  echo

  h1RedUndFont "杭州湾ZK修改结果:\t\t\t"
  find $TARGET -name CacheConfig.xml|grep RUN_HZW_BCORE_PLANE|while read ret;
  do
    echo $ret
    greenFont "$(sed -n '/ConfigItem name="zkServerList".*<\/ConfigItem>$/p' $ret)"
    echo
  done

  h1RedUndFont "浙东灰度ZK修改结果:\t\t\t"
  find $TARGET -name CacheConfig.xml|grep RUN_ZD_B0DOT1_PLANE|while read ret;
  do
    echo $ret
    greenFont "$(sed -n '/ConfigItem name="zkServerList".*<\/ConfigItem>$/p' $ret)"
    echo
  done
  echo

  h1RedUndFont "浙东Redis修改结果:\t\t\t"
  find $TARGET -name CacheConfig.xml|grep RUN_ZD_BCORE_PLANE|while read ret;
  do
    echo $ret
    greenFont "$(sed -n '/<server server_code="M".*\/>$/p' $ret)"
  echo
  done
  echo

  h1RedUndFont "杭州湾Redis修改结果:\t\t\t"
  find $TARGET -name CacheConfig.xml|grep RUN_HZW_BCORE_PLANE|while read ret;
  do
    echo $ret
    greenFont "$(sed -n '/<server server_code="M".*\/>$/p' $ret)"
  echo
  done
  echo

  h1RedUndFont "浙东灰度Redis修改结果:\t\t\t"
  find $TARGET -name CacheConfig.xml|grep RUN_ZD_B0DOT1_PLANE|while read ret;
  do
    echo $ret
    greenFont "$(sed -n '/<server server_code="M".*\/>$/p' $ret)"
  echo
  done
  echo

  h1RedUndFont "浙东产品缓存修改结果:\t\t\t"
  find $TARGET -name CacheConfig.xml|grep RUN_ZD_BCORE_PLANE|while read ret;
  do
    echo $ret
    greenFont "$(sed -n '/<server server_code="PceRedisCache" .*belong_group="redis_group[0-9].*\/>$/p' $ret)"
  done
  echo

  h1RedUndFont "杭州湾产品缓存修改结果:\t\t\t"
  find $TARGET -name CacheConfig.xml|grep RUN_HZW_BCORE_PLANE|while read ret;
  do
    echo $ret
    greenFont "$(sed -n '/<server server_code="PceRedisCache" .*belong_group="redis_group[0-9].*\/>$/p' $ret)"
  done

  h1RedUndFont "浙东灰度产品缓存修改结果:\t\t\t"
  find $TARGET -name CacheConfig.xml|grep RUN_ZD_B0DOT1_PLANE|while read ret;
  do
    echo $ret
    greenFont "$(sed -n '/<server server_code="PceRedisCache" .*belong_group="redis_group[0-9].*\/>$/p' $ret)"
  done
}
# Usage prompt
function usage(){
  cat <<_EOF
    $(h1RedUndFont "自动修改固化配置文件\n")
    $(greenFont "Usage:")
    bash $0 目标目录 操作

    $(greenFont "Example:") 
    bash $0 $HOME/workspace/config-esop rename

    $(greenFont "action:")
    rename: 重命名平面目录
    csf:  修改csf.xml配置文件
    csfCache: 修改csf模块cache.xml配置文件
    logback: csf,exe,msg,cache模块新增logback.xml文件
_EOF
}
case $2 in                                                             
  rename)
    renamingPlane
    ;;
  csf)
    csfModify
    ;;
  csfCache)
    csfCache
    ;;
  logback)
    addLogback
    ;;
  cacheConfig)
    cacheConfig
    ;;
  main)
    renamingPlane
    csfModify
    csfCache
    ;;
  *)
    usage
    ;;
esac
