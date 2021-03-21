#!/bin/sh
# Script, that converts CSV to HTML table and inserts it 
# between <!--insert_table--!> and <!--end_of_table--!>.

FILE="$1"
TABLE="$2"
TAG_START="$3"
TAG_END="$4"

if [ -z "$FILE" ]; then
   echo "csvtohtml: No HTML file provided";
   exit;
fi
if [ -z "$TABLE" ]; then
   echo "csvtohtml: No table file provided";
   exit;
fi
if [ -z "$TAG_START" ]; then
   echo "csvtohtml: No start tag provided";
   exit;
fi
if [ -z "$TAG_END" ]; then
   echo "csvtohtml: No end tag provided";
   exit;
fi

FIRSTLINE=$(awk "/$TAG_START/{print NR}" "$FILE") 
SECONDLINE=$(awk "/$TAG_END/{print NR}" "$FILE") 


addtable() {
   awk "NR==1,NR==$FIRSTLINE" "$FILE"

   csvtohtml "$TABLE" \
      | sed 's/^/   /' \
      | tr '\"' ' ' \
      | tr '-' ' '

   awk "NR==$SECONDLINE,NR==EOF" "$FILE"
}

addtable > "$1".new
mv "$1".new "$1"
rm "$1".new
