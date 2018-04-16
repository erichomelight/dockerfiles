#!/bin/bash

readonly HEROKU_REFERS='heroku_refers.log'
readonly HEROKU_ROUTER='heroku_router.log'
readonly REFERS_UNIQUE='refers_unique.log'

echo "Copying ${INPUT_LOG_FILE} from S3 at ${INPUT_S3_PATH}/$INPUT_LOG_FILE} ..."
aws s3 cp s3://${INPUT_S3_PATH}/${INPUT_LOG_FILE} --region ${AWS_REGION} ./${INPUT_LOG_FILE}

echo "Unzip ${INPUT_LOG_FILE}"
pigz -d ./${INPUT_LOG_FILE}

echo "Split file into router and webapp"
awk '{if(/router/) {print > "'${HEROKU_ROUTER}'"} else if(/app web/) {print > "'${HEROKU_REFERS}'"}}' ./${INPUT_LOG_FILE%.*}
rm  ./${INPUT_LOG_FILE%.*}

echo "reduce filesize to make process more manageable"
sed  -e 's/[^]]*\[/\[/'  -e 's/\][^]]*\[/\] \[/g'  -e 's/\][^[]*$/\]/' ${HEROKU_REFERS} | parallel --pipe awk \'\!seen[\$0]++\' | awk '!seen[$0]++' > ${REFERS_UNIQUE}

if [ -e ./${HEROKU_ROUTER} -a -e ./${REFERS_UNIQUE} ]
then
    echo "files are ok"
else
    echo "files are not ok"
fi
