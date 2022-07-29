#!/bin/bash
array_args=("$@")
echo 'Executing DBT with following parameters:' "${array_args[@]}"
array_args=("$@")
dbt "${array_args[@]}"
exit_code=$?
if [ "${array_args[0]}" == "test" ] && test -n "${DATAHUB_GMS_URL-}"; then
    echo 'Sending tests reports to DataHub:' "${DATAHUB_GMS_URL}"
    datahub ingest -c datahub_assertions.yml
fi
echo 'End of the script'
exit $exit_code
