#!/bin/bash
set -e
echo 'Running Script'  
args=$3
array_args=($args)

if [ ${array_args[4]} == "test" ]; then
        dbt "${array_args[@]:4}"
        datahub ingest -c datahub.yml
    else
        "${array_args[@]:2}"
    fi
echo 'End of the script'