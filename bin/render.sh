#!/usr/bin/env bash

me=$(basename $0)
if [ -n "$KCCODE_HOME" ]
then
  : # do nothing
else
  export KCCODE_HOME="${HOME}/kcdc2013/"
fi

HEADER=${KCCODE_HOME}assets/header
LINKS=${KCCODE_HOME}assets/stories/links/
NAME=index
NET=${KCCODE_HOME}bin/__networked.sh
SEW=${KCCODE_HOME}bin/__sew.sh
STORY=${KCCODE_HOME}assets/stories/
TMP_DIR=/tmp/kcc/${RANDOM}/

rm  -rf $TMP_DIR;mkdir -p $TMP_DIR
cp $HEADER ${TMP_DIR}_header

OPTIND=1
is_dev=0
while getopts "h?d" opt; do
  case "$opt" in
    h|\?)
      echo ""
      echo ""
      echo "  > $0 # or..."
      echo "  > $0 -d # debug layout with 'X' character "
      echo ""
      cat ${KCCODE_HOME}/README.md
      exit 0
      ;;
    d) is_dev=1
      ;;
   esac
done
shift $((OPTIND-1))

echo -n "Generating page..."
$NET "$LINKS" "$STORY" "$TMP_DIR"

HEADER=${TMP_DIR}_header
$SEW "$HEADER" "$NAME" "$STORY" "$TMP_DIR" "$is_dev"
rm  -rf ${TMP_DIR}
echo ""
echo "done.";echo "";echo -n "  > Moving HTML file..."
mv ${KCCODE_HOME}${NAME}.html ${KCCODE_HOME}scotty/${NAME}.html
echo "done."
echo ""
