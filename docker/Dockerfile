FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
        bash \
        dos2unix \
        jq \
        wget

RUN wget -P /usr/bin/ --no-check-certificate https://storage.googleapis.com/kubernetes-release/release/$(wget --no-check-certificate -O - https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl

COPY *.sh /scripts/

RUN dos2unix /scripts/*.sh && \
    chmod u+x /scripts/*.sh
