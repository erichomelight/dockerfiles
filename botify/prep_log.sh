#!/bin/bash

#readonly HEROKU_REFERS='heroku_refers.log'
#readonly HEROKU_ROUTER='heroku_router.log'
#readonly REFERS_HEROKU='/var/scratch/refers_heroku.log'

echo "Copying ${INPUT_LOG_FILE} from S3 at ${INPUT_S3_PATH}/$INPUT_LOG_FILE ..."
aws s3 cp s3://${INPUT_S3_PATH}/${INPUT_LOG_FILE} --region ${AWS_REGION} ./${INPUT_LOG_FILE}

#echo "Unzip ${INPUT_LOG_FILE}"


#echo "Get only the referer part"
#awk '{if(/app web/) {print > "'${REFERS_HEROKU}'"}}' ./${INPUT_LOG_FILE%.*}

echo "reduce filesize to make process more manageable"
gunzip -c ./${INPUT_LOG_FILE} | sed  -e 's/[^]]*\[/\[/'  -e 's/\][^]]*\[/\] \[/g'  -e 's/\][^[]*$/\]/' | awk '!seen[$0]++' > ${HEROKU_REFERS}

echo 'Get only the router part'
gunzip -c ./${INPUT_LOG_FILE} | awk '{if(/router/) {print > "'${HEROKU_ROUTER}'"}}'
rm  ./${INPUT_LOG_FILE}
# if [ -e ./${HEROKU_ROUTER} -a -e ./${HEROKU_REFERS} ]
# then
#     echo "files are ok"
# else
#     echo "files are not ok"
# fi
