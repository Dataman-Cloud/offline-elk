#!/bin/bash
set -e

. ../config.cfg

docker exec -it elk_elasticsearch_1 curator --timeout 36000 --host 127.0.0.1 delete indices --older-than $ES_DATA_KEEP_DAY --time-unit days --timestring '%Y-%m-%d' --prefix "dataman-"

