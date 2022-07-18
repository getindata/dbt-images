#!/bin/bash
set -e
echo 'Running Script'
array_args=( "$@" )
if [ "${array_args[2]}" == "test" ] && test -n "${DATAHUB_GMS_URL-}"; then
        echo  dbt "${array_args[@]:2}"
        dbt "${array_args[@]:2}"
        echo "${DATAHUB_GMS_URL}"
        datahub ingest -c datahub_assertions.yml
    else
        echo "${array_args[@]}"
        "${array_args[@]}"
    fi
echo 'End of the script'