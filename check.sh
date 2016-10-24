#!/bin/bash

function check_port(){
	name=$1
	port=$2
	netstat -lntp|grep $port &>/dev/null  && echo "$name is ok" || (echo "$name is error";exit 1)
}

check_port logstash 5011
check_port kibana 5601
curl http://127.0.0.1:9200/_cluster/health 2>/dev/null|python -m json.tool|grep 'status.*green' &>/dev/null && echo "elasticsearch is ok" || (echo "elasticsearch is error"; exit 1)

