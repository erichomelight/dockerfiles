#!/bin/bash

#readonly HEROKU_REFERS='heroku_refers.log'
#readonly HEROKU_ROUTER='heroku_router.log'
readonly REFERS_HEROKU='/var/scratch/refers_heroku.log'

echo "Copying ${INPUT_LOG_FILE} from S3 at ${INPUT_S3_PATH}/$INPUT_LOG_FILE ..."
aws s3 cp s3://${INPUT_S3_PATH}/${INPUT_LOG_FILE} --region ${AWS_REGION} ./${INPUT_LOG_FILE}

echo "Unzip ${INPUT_LOG_FILE}"
pigz -d ./${INPUT_LOG_FILE}

echo "Split file into router and webapp"
awk '{if(/router/) {print > "'${HEROKU_ROUTER}'"} else if(/app web/) {print > "'${REFERS_HEROKU}'"}}' ./${INPUT_LOG_FILE%.*}
rm  ./${INPUT_LOG_FILE%.*}

echo "reduce filesize to make process more manageable"
sed  -e 's/[^]]*\[/\[/'  -e 's/\][^]]*\[/\] \[/g'  -e 's/\][^[]*$/\]/' ${REFERS_HEROKU} | parallel --pipe awk \'\!seen[\$0]++\' | awk '!seen[$0]++' > ${HEROKU_REFERS}

# if [ -e ./${HEROKU_ROUTER} -a -e ./${HEROKU_REFERS} ]
# then
#     echo "files are ok"
# else
#     echo "files are not ok"
# fi
