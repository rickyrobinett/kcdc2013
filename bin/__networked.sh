#!/usr/bin/env bash

LINKS=$1
STORY=$2
TMP_DIR=$3

while read line; do
if [[ "$line" =~ "LINK_" ]]; then
  name=${line%% =*}
  value=${line##*= }
  value=${value//\//\\\/} # escape forward-slashes e.g. http:// --> http:\/\/ 
  sed -i "s/{{${name}}}/${value}/g" "${TMP_DIR}_header"
fi
done < "${LINKS}0"

for f in $(find ${STORY} -maxdepth 1 -name [0-9]*); do
  filename=$(basename $f)
  cp ${STORY}${filename} ${TMP_DIR}_story${filename}
  while read line; do
  if [[ "$line" =~ "LINK_" ]]; then
    name=${line%% =*}
    value=${line##*= }
    value=${value//\//\\\/} # escape forward-slashes e.g. http:// --> http:\/\/ 
    value=${value//\&/\\\&} # escape ampersands 
    sed -i "s/{{${name}}}/${value}/g" ${TMP_DIR}_story${filename}
  fi
  done < ${LINKS}${filename}
done

