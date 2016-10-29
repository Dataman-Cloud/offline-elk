#!/bin/bash
set -e

base_dir=$(cd `dirname $0` && pwd)
cd $base_dir
./build_config.sh

job_cmd="/data/offlinesry/offline-elk/clean_es.sh"

crontab -l 2>/dev/null|grep -F "$job_cmd" || (crontab -l 2>/dev/null;echo "0 4 * * * $job_cmd" ) | crontab -

docker-compose -p dataman up -d
