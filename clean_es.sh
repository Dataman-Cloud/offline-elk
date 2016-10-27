#!/bin/bash
set -e
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
. ../config.cfg

docker exec -it elk_elasticsearch_1 curator --timeout 36000 --host 127.0.0.1 delete indices --older-than $ES_DATA_KEEP_DAY --time-unit days --timestring '%Y-%m-%d' --prefix "dataman-"

