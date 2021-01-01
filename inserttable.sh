#!/bin/sh
# Script, that converts CSV to HTML table and inserts it 
# between <!--insert_table--!> and <!--end_of_table--!>.

FILE="$1"
TABLE="$2"

if [ -z "$FILE" ]; then
   echo "csvtohtml: No HTML file provided";
   exit;
fi
if [ -z "$TABLE" ]; then
   echo "csvtohtml: No table file provided";
   exit;
fi

FIRSTLINE=$(awk '/<!--insert_table--!>/{print NR}' "$FILE") 
SECONDLINE=$(awk '/<!--end_of_table--!>/{print NR}' "$FILE") 


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
