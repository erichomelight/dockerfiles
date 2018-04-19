#!/bin/bash

echo "Copying ${OUTPUT_LOG_FILE}.gz to S3 at ${OUTPUT_S3_PATH}/${OUTPUT_LOG_FILE} ..."
pigz ./${OUTPUT_LOG_FILE}
aws s3 cp ./${OUTPUT_LOG_FILE}.gz s3://${OUTPUT_S3_PATH}/${OUTPUT_LOG_FILE}.gz --region ${AWS_REGION}
