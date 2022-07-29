#!/bin/bash
array_args=("$@")
echo 'Executing DBT with following parameters:' "${array_args[@]}"
array_args=("$@")
if dbt "${array_args[@]}" ; then
    exit_code=0
    echo "Command succeeded"
else
    exit_code=1
    echo "Command failed"
fi
if [ "${array_args[0]}" == "test" ] && test -n "${DATAHUB_GMS_URL-}"; then
    echo 'Sending tests reports to DataHub:' "${DATAHUB_GMS_URL}"
    datahub ingest -c datahub_assertions.yml
fi
echo 'End of the script'
exit $exit_code
