#! /bin/bash

FILE_NAME=$1


usage(){
echo "$0 [arguments] [options]"
echo "$0: Tool to parse nginx log file."
echo "Arguments:"
echo "<log_file> Path to the nginx log file to parse"
echo "Options:"
echo "-h, --help Display this help message"
echo "-s, --status Parse log file for specific HTTP status code"
echo "-m, --method Parse log file for specific HTTP method"
}

if [[ $# -eq 0 ]]
then
	usage
	exit 1
fi

if [[ ! -f $FILE_NAME ]]
then
	echo "File does not exist"
fi

if [[ ! -r $FILE_NAME ]]
then
	echo "File is not readable"
fi


ip(){
	cat $FILE_NAME | awk '{ print $1 }' | uniq -c | sort -r | head -5
}
Total_request(){
	wc -l $FILE_NAME | awk '{ print $1 }'
}
endpoint(){
	cat $FILE_NAME | cut -d '"' -f2 | awk '{ print $2 }' | sort | uniq -c | sort -r | head -5
}
status_code(){
	cat $FILE_NAME | grep -Eo "[2-5][0-9][0-9]" | sort | uniq -c | sort -r | head -5
}
ip
Total_request
endpoint
status_code
slow_req(){
	cat nginx.log | cut -d '"' -f2,8 | tr '"' ' ' | sort -k4,4nr | head -5
}
slow_req
