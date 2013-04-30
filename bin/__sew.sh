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

TOCOLUMBIA='  <a href="#columbia" id="corner_to_columbia">Columbia</a>                                                                                 '
TOJEFFC='  <a    href="#jeffc"    id="corner_to_jeffc"   >Jefferson City</a>                                                                           '
TOKC='  <a       href="#kc"       id="corner_to_kc"      >Kansas City</a>                                                                              '
TOKIRKS='  <a    href="#kirks"    id="corner_to_kirks"   >Kirksville</a>                                                                               '
TOLAWRENCE='  <a href="#law"      id="corner_to_law"     >Lawrence</a>                                                                                 '
TOMANHAT='  <a   href="#manhat"   id="corner_to_manhat"  >Manhattan</a>                                                                                '
TOSTLOUIS='  <a  href="#stlouis"  id="corner_to_stlouis" >St. Louis</a>                                                                                '

COLUMBIATOKC='                                            \&lt;-- <a href="#kc" id="columbia_to_kc">KANSAS CITY, MO</a> 125mi                      '
COLUMBIATOJEFFC='                         V   <a href="#jeffc" id="columbia_to_jeffc">JEFFERSON CITY, MO</a> 31mi                                       '
COLUMBIATOKIRKS='                          ^   <a href="#kirks" id="columbia_to_kirks">KIRKSVILLE, MO</a> 91mi                                          '
COLUMBIATOSTLOU='                         <a href="#stlouis" id="columbia_to_stlouis">ST. LOUIS, MO</a> 125mi --\&gt;                                           '

JEFFCTOCOLUMBIA='                        ^       <a href="#columbia" id="jeffc_to_columbia">COLUMBIA, MO</a> 32mi                                          '

KCTOCOLUMBIA='              <a href="#columbia" id="kc_to_columbia">COLUMBIA, MO</a> 125mi --\&gt;                                                       '
KCTOJEFFC='              V  <a href="#jeffc" id="kc_to_jeffc">JEFFERSON CITY, MO</a> 157mi                                                  '
KCTOKIRKS='                            <a href="#kirks" id="kc_to_kirks">KIRKSVILLE, MO</a> 180mi              ^                            '
KCTOLAW='                       \&lt;--- <a href="#law" id="kc_to_law">LAWRENCE, KS</a> 40mi                                              '

KIRKSTOCOLUMBIA='                        V       <a href="#stlouis" id="kirks_to_columbia">COLUMBIA, MO</a> 91mi                                          '
KIRKSTOKC='                        V       <a href="#kc" id="kirks_to_kc">KANSAS CITY, MO</a> 180mi                                      '

LAWTOKC='    <a href="#kc" id="law_to_kc">KANSAS CITY, KS</a> 40mi --\&gt;                                                               '
LAWTOMANHAT='                                                                \&lt;--- <a href="#manhat" id="law_to_manhat">MANHATTAN, KS</a> 84mi    '
 
MANHATTOLAW='    <a href="#kc" id="manhat_to_law">LAWRENCE, KS</a> 84mi --\&gt;                                                                  '


STLOUTOCOLUMBIA='                                                                  \&lt;-- <a href="#columbia" id="stlou_to_columbia">COLUMBIA, MO</a> 125mi   '

echo "";echo -n "  > interpolating links..."

sed $PANEL   -e "10s!${ROW}!${JEFFCTOCOLUMBIA}!"                      > ${TMP_DIR}_jeffc_to_columbia

sed $SPANEL   -e "71s!${ROW}!${COLUMBIATOKC}!"                        > ${TMP_DIR}_columbia_to_kc
sed $SPANEL   -e "41s!${ROW}!${COLUMBIATOKIRKS}!"                     > ${TMP_DIR}_columbia_to_kirks0
sed ${TMP_DIR}_columbia_to_kirks0 -e "47s!${ROW}!${COLUMBIATOJEFFC}!" > ${TMP_DIR}_columbia_to_kirks1
sed ${TMP_DIR}_columbia_to_kirks1 -e "53s!${ROW}!${COLUMBIATOSTLOU}!" > ${TMP_DIR}_columbia_to_kirks

sed $SPANEL   -e "60s!${ROW}!${KCTOCOLUMBIA}!"                        > ${TMP_DIR}_kc_to_columbia0
sed ${TMP_DIR}_kc_to_columbia0    -e "65s!${ROW}!${KCTOJEFFC}!"       > ${TMP_DIR}_kc_to_columbia
sed ${PANEL}  -e "437s!${ROW}!${KCTOKIRKS}!"                          > ${TMP_DIR}_kc_to_kirks
sed $SPANEL   -e "60s!${ROW}!${KCTOLAW}!"                             > ${TMP_DIR}_kc_to_law

sed ${PANEL}  -e "71s!${ROW}!${KIRKSTOKC}!"                           > ${TMP_DIR}_kirks_to_kc
sed ${PANEL}  -e "91s!${ROW}!${KIRKSTOCOLUMBIA}!"                     > ${TMP_DIR}_kirks_to_columbia

sed ${SPANEL} -e "30s!${ROW}!${LAWTOKC}!"                             > ${TMP_DIR}_law_to_kc
sed ${SPANEL} -e "30s!${ROW}!${LAWTOMANHAT}!"                         > ${TMP_DIR}_law_to_manhat

sed ${SPANEL} -e "30s!${ROW}!${MANHATTOLAW}!"                         > ${TMP_DIR}_manhat_to_law

sed ${SPANEL} -e "30s!${ROW}!${STLOUTOCOLUMBIA}!"                     > ${TMP_DIR}_stlou_to_columbia

echo "";echo -n "  > interpolating anchors..."
sed -r "4 ~ s/^(.{1})(.{1})/\1${COLUMBIA_ANCHOR}\2<\/a>/"       ${TMP_DIR}/_columbia_to_kc > ${TMP_DIR}_columbia_anchor
sed -r "4 ~ s/^(.{1})(.{1})/\1${JEFFC_ANCHOR}\2<\/a>/"          ${TMP_DIR}/_story11        > ${TMP_DIR}_jeffc_anchor
sed -r "4 ~ s/^(.{85})(.{1})/\1${KC_ANCHOR}\2<\/a>/"            ${TMP_DIR}/_story1         > ${TMP_DIR}_kc_anchor
sed -r "4 ~ s/^(.{1})(.{1})/\1${KIRKS_ANCHOR}\2<\/a>/"          ${TMP_DIR}_kirks_to_kc     > ${TMP_DIR}_kirks_anchor
sed -r "4 ~ s/^(.{1})(.{1})/\1${LAWRENCE_ANCHOR}\2<\/a>/"       ${TMP_DIR}/_story7         > ${TMP_DIR}_law_anchor
sed -r "4 ~ s/^(.{1})(.{1})/\1${MANHAT_ANCHOR}\2<\/a>/"         ${TMP_DIR}/_story10        > ${TMP_DIR}_manhat_anchor
sed -r "4 ~ s/^(.{1})(.{1})/\1${STLOUIS_ANCHOR}\2<\/a>/"        ${TMP_DIR}/_story9         > ${TMP_DIR}_stlouis_anchor

sed $PANEL              -e "3s!${ROW}!${TOKC}!"                 > ${TMP_DIR}_legend_1
sed ${TMP_DIR}_legend_1 -e "4s!${ROW}!${TOKIRKS}!"              > ${TMP_DIR}_legend_2
sed ${TMP_DIR}_legend_2 -e "5s!${ROW}!${TOCOLUMBIA}!"           > ${TMP_DIR}_legend_3
sed ${TMP_DIR}_legend_3 -e "6s!${ROW}!${TOJEFFC}!"              > ${TMP_DIR}_legend_4
sed ${TMP_DIR}_legend_4 -e "7s!${ROW}!${TOSTLOUIS}!"            > ${TMP_DIR}_legend_5
sed ${TMP_DIR}_legend_5 -e "8s!${ROW}!${TOLAWRENCE}!"           > ${TMP_DIR}_legend_6
sed ${TMP_DIR}_legend_6 -e "9s!${ROW}!${TOMANHAT}!"             > ${TMP_DIR}_legend

echo "";echo -n "  > Creating columns..."

# BLANK 
cat $PANEL                       \
    $PANEL                       \
    $SPANEL                      \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}blank

# ---

#COLUMBIA TO KC
cat ${TMP_DIR}_kirks_to_columbia \
    $PANEL                       \
    ${TMP_DIR}_columbia_anchor   \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}columbia_to_kc

#COLUMBIA TO KIRKS
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_columbia_to_kirks \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}columbia_to_kirks

#JEFFERSON CITY TO COLUMBIA
cat $PANEL                       \
    $PANEL                       \
    $SPANEL                      \
    ${TMP_DIR}_jeffc_to_columbia \
    $PANEL                       > ${TMP_DIR}jeffc_to_columbia

#KC TO COLUMBIA
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_kc_to_columbia    \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}kc_to_columbia

#KC TO LAWRENCE
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_kc_to_law         \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}kc_to_law

#KIRKS TO KC
cat ${TMP_DIR}_kirks_anchor      \
    $PANEL                       \
    $SPANEL                      \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}kirks_to_kc

#LAWRENCE TO KC
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_law_to_kc         \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}law_to_kc

#LAWRENCE TO MANHATTAN
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_law_to_manhat     \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}law_to_manhat

#MANHATTAN TO LAWRENCE
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_manhat_to_law     \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}manhat_to_law

#ST. LOUIS TO COLUMBIA
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_stlou_to_columbia \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}stlou_to_columbia

# ---

#BACHMAN
cat ${TMP_DIR}_legend            \
    $PANEL                       \
    ${TMP_DIR}_manhat_anchor     \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}story10

#BELL
cat ${TMP_DIR}_story5            \
    $PANEL                       \
    $SPANEL                      \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}story5

#CARMACK
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_story3            \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}story3

#DORSEY
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_stlouis_anchor    \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}story9

#KCS
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_kc_anchor         \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}story1

#GARMIN
cat $PANEL                       \
    ${TMP_DIR}_kc_to_kirks       \
    ${TMP_DIR}_story4            \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}story4

#KILBY
cat $PANEL                       \
    $PANEL                       \
    $SPANEL                      \
    ${TMP_DIR}_jeffc_anchor      \
    $PANEL                       > ${TMP_DIR}story11

#MONTULLI
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_law_anchor        \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}story7

#WIENER
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_story6            \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}story6

#WILLIAMS
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_story8            \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}story8

#WINGZ
cat $PANEL                       \
    $PANEL                       \
    ${TMP_DIR}_story2            \
    $PANEL                       \
    $PANEL                       > ${TMP_DIR}story2

paste -d "$DELIMITER" ${TMP_DIR}story10 ${TMP_DIR}manhat_to_law ${TMP_DIR}blank ${TMP_DIR}blank ${TMP_DIR}blank ${TMP_DIR}blank ${TMP_DIR}law_to_manhat ${TMP_DIR}story8 ${TMP_DIR}story7 ${TMP_DIR}law_to_kc ${TMP_DIR}blank ${TMP_DIR}kc_to_law ${TMP_DIR}story1 ${TMP_DIR}story2 ${TMP_DIR}story3 ${TMP_DIR}story4 ${TMP_DIR}kc_to_columbia ${TMP_DIR}blank ${TMP_DIR}kirks_to_kc ${TMP_DIR}story5 ${TMP_DIR}columbia_to_kc ${TMP_DIR}story6 ${TMP_DIR}columbia_to_kirks ${TMP_DIR}story11 ${TMP_DIR}jeffc_to_columbia ${TMP_DIR}blank ${TMP_DIR}blank ${TMP_DIR}stlou_to_columbia ${TMP_DIR}story9 > ${TMP_DIR}${NAME};
echo "done.";echo -n "  > creating html file..."
cat $HEADER ${TMP_DIR}${NAME} ${FOOTER} > ${NAME}.html
echo "done."
