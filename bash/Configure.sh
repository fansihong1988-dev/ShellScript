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
  set -u
  h1RedUndFont "Modify the csf.xml configuration file\t\t\t\t\t\t\t"
  find $TARGET -name csf.xml|while read csf;
  do
    grep '<tenant>' ${csf} > /dev/null
    if [[ $? -ne 0 ]];then
      cp -f $(dirname $0)/csf-transform-xml.jar ${csf%/*}
      if [[ -f ${csf%/*}/csf-transform-xml.jar ]];then
        cd ${csf%/*};java -jar csf-transform-xml.jar csf.xml
        if [[ -f csf-3.2.xml ]];then
          mv csf-3.2.xml csf.xml
        fi
      fi
    fi
    sed -i "" 's/<tenant>.*<\/tenant>/<tenant>TN_ZJ_ITOMD<\/tenant>/' $csf # replace "<tenant>string</tenant>"
    if [[ $(echo $csf|grep -o 'RUN_ZD_BCORE_PLANE') == RUN_ZD_BCORE_PLANE ]];then # Modify RUN_ZD_BCORE_PLANE zookeeper configure
      sed -i "" '/<NameServer:zk>/,/<\/NameServer:zk>/d' $csf
      sed -i "" '/<\/ProcInfo>/r RUN_ZD_BCORE_PLANE-csf-zk.xml' $csf
    elif [[ $(echo $csf|grep -o 'RUN_HZW_BCORE_PLANE') == RUN_HZW_BCORE_PLANE ]];then # Modify RUN_HZW_BCORE_PLANE zookeeper configure
      sed -i "" '/<NameServer:zk>/,/<\/NameServer:zk>/d' $csf
      sed -i "" '/<\/ProcInfo>/r RUN_HZW_BCORE_PLANE-csf-zk.xml' $csf
    elif [[ $(echo $csf|grep -o 'RUN_ZD_B0DOT1_PLANE') == RUN_ZD_B0DOT1_PLANE ]];then # Modify RUN_ZD_B0DOT1_PLANE zookeeper configure 
      sed -i "" '/<NameServer:zk>/,/<\/NameServer:zk>/d' $csf
      sed -i "" '/<\/ProcInfo>/r RUN_ZD_B0DOT1_PLANE-csf-zk.xml' $csf
    fi
  done
  echo
  whiteBoldFont "汇总:"
}

case $2 in
  rename)
    renamingPlane
    ;;
  csf)
    csfModify
    ;;
  *)
    usage
    ;;
esac
