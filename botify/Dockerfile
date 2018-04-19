FROM        debian:jessie AS base
#ubuntu:16.04 AS base

WORKDIR     /tmp/workdir

RUN     apt-get -yqq update && \
#        apt-get install -yq --no-install-recommends ca-certificates expat libgomp1 && \
        apt-get install parallel gawk sed python-yaml pigz python-dev python-pip -y && \
        apt-get autoremove -y && \
        apt-get clean -y

FROM base as build

ENV HEROKU_ROUTER="/var/scratch/heroku_router.log"
ENV HEROKU_REFERS="/var/scratch/heroku_refers.log"

RUN pip install awscli

COPY *_log.* /tmp/workdir/

ENTRYPOINT ./prep_log.sh && python ./generate_log.py $HEROKU_ROUTER $HEROKU_REFERS $OUTPUT_LOG_FILE  && ./copy_log.sh
