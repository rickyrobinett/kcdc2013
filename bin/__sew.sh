#!/usr/bin/env bash

DELIMITER="  "
FOOTER=${KCCODE_HOME}assets/footer
HEADER=$1
IS_DEV=$5
NAME=$2
PANEL_Xs=${KCCODE_HOME}assets/panel.Xs
PANEL_BLANK=${KCCODE_HOME}assets/panel.blank
PANEL="$PANEL_BLANK"
ROW_Xs=`printf 'X%.0s' {1..91}`
ROW_BLANK=`printf ' %.0s' {1..91}`
ROW="$ROW_BLANK"
STORY=$3
TMP_DIR=$4
STORY_Xs=${STORY}b.Xs
STORY_BLANK=${STORY}b.blank
SPANEL="$STORY_BLANK"

one=1
if [[ $IS_DEV -eq $one ]]; then
  echo 'development mode; layout character will be "X".'
  PANEL="$PANEL_Xs"
  ROW="$ROW_Xs"
  SPANEL="$STORY_Xs"
fi

COLUMBIA_ANCHOR='<a id="columbia">'
JEFFC_ANCHOR='<a    id="jeffc">'
KC_ANCHOR='<a       id="kc">'
KIRKS_ANCHOR='<a    id="kirks">'
LAWRENCE_ANCHOR='<a id="law">'
MANHAT_ANCHOR='<a   id="manhat">'
STLOUIS_ANCHOR='<a  id="stlouis">'

echo "";echo -n "  > interpolating links..."

echo "";echo -n "  > interpolating anchors..."
sed -r "4 ~ s/^(.{1})(.{1})/\1${COLUMBIA_ANCHOR}\2<\/a>/"       ${TMP_DIR}/_story6         > ${TMP_DIR}_columbia_anchor
sed -r "4 ~ s/^(.{1})(.{1})/\1${JEFFC_ANCHOR}\2<\/a>/"          ${TMP_DIR}/_story11        > ${TMP_DIR}_jeffc_anchor
sed -r "4 ~ s/^(.{85})(.{1})/\1${KC_ANCHOR}\2<\/a>/"            ${TMP_DIR}/_story1         > ${TMP_DIR}_kc_anchor
sed -r "4 ~ s/^(.{1})(.{1})/\1${KIRKS_ANCHOR}\2<\/a>/"          ${TMP_DIR}/_story5         > ${TMP_DIR}_kirks_anchor
sed -r "4 ~ s/^(.{1})(.{1})/\1${LAWRENCE_ANCHOR}\2<\/a>/"       ${TMP_DIR}/_story7         > ${TMP_DIR}_law_anchor
sed -r "4 ~ s/^(.{1})(.{1})/\1${MANHAT_ANCHOR}\2<\/a>/"         ${TMP_DIR}/_story10        > ${TMP_DIR}_manhat_anchor
sed -r "4 ~ s/^(.{1})(.{1})/\1${STLOUIS_ANCHOR}\2<\/a>/"        ${TMP_DIR}/_story9         > ${TMP_DIR}_stlouis_anchor

paste -d "$DELIMITER" ${TMP_DIR}_story10 ${TMP_DIR}_story8 ${TMP_DIR}_story7 ${TMP_DIR}_story1 ${TMP_DIR}_story2 ${TMP_DIR}_story3 ${TMP_DIR}_story4 ${TMP_DIR}_story5 ${TMP_DIR}_story6 ${TMP_DIR}_story11 ${TMP_DIR}_story9 > ${TMP_DIR}${NAME};
echo "done.";echo -n "  > creating html file..."
cat $HEADER ${TMP_DIR}${NAME} ${FOOTER} > ${NAME}.html
echo "done."
