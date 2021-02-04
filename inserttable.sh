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

addtable > "$FILE".new;
cp "$FILE".new "$FILE";
rm "$FILE".new;
