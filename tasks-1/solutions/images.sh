#! /bin/bash

#set -ex

FILEPATH=$1
#TOTAL_FILES=$(cat $FILEPATH | grep "id" | cut -d ":" -f 2 | tr -d "," | tail -1)
URL=$(cat $FILEPATH | grep "url" | awk '{ print $2 }' | tr -d '"')
DEST_DIR=/tmp/images

rm -rf $DEST_DIR
mkdir -p $DEST_DIR

for i in $URL
do
	FILENAME=$(echo $i | cut -d "/" -f 5)
       	curl -s $i -o $DEST_DIR/$FILENAME
	ls -lh $DEST_DIR/$FILENAME | awk '{ print $5, $9 }'
done
