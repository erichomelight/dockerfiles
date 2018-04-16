FROM        debian:jessie AS base
#ubuntu:16.04 AS base

WORKDIR     /tmp/workdir

RUN     apt-get -yqq update && \
#        apt-get install -yq --no-install-recommends ca-certificates expat libgomp1 && \
        apt-get install parallel gawk sed python-yaml pigz python-dev python-pip -y && \
        apt-get autoremove -y && \
        apt-get clean -y

FROM base as build

#ENV       %%ENV%%

RUN pip install awscli pyparsing

COPY copy_log.sh /tmp/workdir

ENTRYPOINT get_file.sh && unzip_and_proc.sh && python ./generate.py && ./copy_log.sh
