#!/bin/bash
set -e
array_args=( "$@" )
echo 'Executing DBT with following parameters:' "${array_args[@]}"
if [ "${array_args[0]}" == "test" ] && test -n "${DATAHUB_GMS_URL-}"; then
        echo dbt "${array_args[@]}"
        dbt "${array_args[@]}"
        echo 'Sending tests reports to DataHub:' "${DATAHUB_GMS_URL}"
        datahub ingest -c datahub_assertions.yml
    else
        echo dbt --no-write-json "${array_args[@]}"
        dbt --no-write-json "${array_args[@]}"
    fi
echo 'End of the script'