#!/bin/bash

set -eu

. ../config.cfg

#export LC_CTYPE=C 

replace_var(){
    files=$@
    echo $files | xargs sed -i 's#--ES_CLUSTER_NAME--#'$ES_CLUSTER_NAME'#g'
    echo $files | xargs sed -i 's#--ES_HEAP_SIZE--#'$ES_HEAP_SIZE'#g'
    echo $files | xargs sed -i 's#--LS_HEAP_SIZE--#'$LS_HEAP_SIZE'#g'
    echo $files | xargs sed -i 's#--LS_WORKERS--#'$LS_WORKERS'#g'
    echo $files | xargs sed -i 's#--LS_FLUSH_SIZE--#'$LS_FLUSH_SIZE'#g'
    echo $files | xargs sed -i 's#--LS_IDLE_FLUSH_TIME--#'$LS_IDLE_FLUSH_TIME'#g'
    echo $files | xargs sed -i 's#--LS_STDOUT_LEVEL--#'"$LS_STDOUT_LEVEL"'#g'
}

pre_conf(){
    rm -f docker-compose.yml
    cp docker-compose.yml.temp docker-compose.yml
    files="docker-compose.yml"
    replace_var $files
}

preconfigserver_conf(){
    rm -rf 
    cp -rf conf_d.temp conf_d_tmp

    files=`grep -rl '' conf_d_tmp/*`
    replace_var $files

    rm -rf conf.d
    mv conf_d_tmp conf.d
}

pre_conf

