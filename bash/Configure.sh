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
      redBoldFont "Delete ${directory}"
      rm -rf ${TARGET}/${directory}
    fi
  done
}

case $2 in
  rename)
    renamingPlane
    ;;
  *)
    usage
    ;;
esac
