#! /bin/bash
# set -x

LOG_FILE=$1

usage(){
    echo "Usage: $0 [arguements] [options]"
    echo "$0: Tool to parse nginx log files."
    echo "Arguments:"
    echo "  <log_file>    Path to the nginx log file to parse"
    echo "Options:"
    echo "  -h, --help     Display this help message"
    echo "  -s, --status   Parse log file for specific HHTP status code"
    echo "  -m, --method   Parse log file for specific HTTP method"
}

check_file_exists(){
    if [[ ! -f $LOG_FILE ]]
    then
        echo "Error: Log file '$LOG_FILE' does not exist."
        exit 1
    fi
}

check_file_readable(){
    if [[ ! -r $LOG_FILE ]]
    then
        echo "Error: Log file '$LOG_FILE' is not readable."
        exit 1
    fi
}

total_requests(){
    TOTAL_REQUESTS=$(wc -l $LOG_FILE)
    # echo "Total requests: $TOTAL_REQUESTS"
}

unique_ips(){
    UNIQUE_IPS=$(awk '{print $1}' $LOG_FILE | uniq | wc -l)
    # echo "Unique IPs: $UNIQUE_IPS"
}

top_ips(){
    IPS=$(awk '{ print $1 }' $LOG_FILE | uniq -c | sort -r | head -5)
    # echo $IPS
}

status_code(){
    STATUS_CODE="200|401|403|404|405|500|501|502|503|504"
    STATUS_COUNT=$(grep -Eo "$STATUS_CODE" $LOG_FILE | sort | uniq -c )
    # echo $STATUS_COUNT
}

top_endpoints(){
    ENDPOINTS=$(cut -d '"' -f 2 $LOG_FILE | awk '{print $2}' | sort | uniq -c | sort -r | head -5)
    # echo $ENDPOINTS
}

top_methods(){
    METHODS=$(cut -d '"' -f 2 $LOG_FILE | awk '{print $1}' | sort | uniq -c | sort -r)
    # echo $METHODS
}

slow_endpoints(){
    SLOW_ENDPOINTS=$(cut -d '"' -f 2,8 $LOG_FILE | tr '"' ' ' | sort -k4,4nr | head -5)
}


beautify_output(){
    echo "==== Log Report ===="
    echo
    echo "Total Requests: $TOTAL_REQUESTS"
    echo "Unique IPs: $UNIQUE_IPS"
    echo
    echo "Top 5 IPs:"
    echo "$IPS"
    echo
    echo "Top 5 Endpoints:"
    echo "$ENDPOINTS"
    echo
    echo "Status Code Count:"
    echo "$STATUS_COUNT"
    echo
    echo "Top 5 Slowest Requests:"
    echo "$SLOW_ENDPOINTS"
}

parse_log(){
    check_file_exists
    check_file_readable
    total_requests
    unique_ips
    top_ips
    status_code
    top_endpoints
    top_methods
    slow_endpoints
    beautify_output
}

if [[ $# -eq 0 ]]
then
    usage
    exit 1
fi

parse_log