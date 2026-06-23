#! /bin/bash

FILE_PATH=/tmp/images.txt

cat images.json | grep url | awk '{ print $2 }' | tr -d '"' > $FILE_PATH

for u in $(cat $FILE_PATH)
do
	IMAGE_NAME=$(echo $u | cut -d "/" -f 5)
	curl $u -s -o $IMAGE_NAME
        ls -lh $IMAGE_NAME | awk '{ print $5, $9 }'
done
