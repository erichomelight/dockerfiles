#!/bin/bash

echo "Copying ${OUTPUT_LOG_FILE} to S3 at ${OUTPUT_S3_PATH}/${OUTPUT_LOG_FILE} ..."
aws s3 cp ./${OUTPUT_LOG_FILE} s3://${OUTPUT_S3_PATH}/${OUTPUT_LOG_FILE} --region ${AWS_REGION}
