#! /bin/bash 

SOURCE_DIR=$1
BKP_DIR="/Users/siddharthshashikar/Work/personal/backup"
FILENAME=$(date +%Y-%m-%d-%H-%M-%S)

mkdir -p $BKP_DIR

zip -r -q $BKP_DIR/$FILENAME.zip $SOURCE_DIR
if [[ $? -ne 0 ]]
then
    echo "ERROR: Fail to create backup"
    exit 1
fi
echo "SUCCESS: Backup create successful: $BKP_DIR/$FILENAME.zip"


ACTIVE_BKP_FILES=$(ls -lt $BKP_DIR | head -n 6 | tail -5 | awk '{print $9}')

for file in $(ls -lt $BKP_DIR/* | cut -d " " -f 11 | cut -d "/" -f 7); do
    echo $file | grep "$ACTIVE_BKP_FILES" > /dev/null
    if [[ $? -ne 0 ]]
    then
        rm $BKP_DIR/$file
        if [[ $? -ne 0 ]]
        then
            echo "ERROR: Fail to delete old backup file: $file"
            exit 1
        fi
        echo "SUCCESS: Remove old backup file: $file"
    fi
done
