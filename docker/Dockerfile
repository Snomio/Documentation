FROM ubuntu:14.04

WORKDIR /opt/data

RUN apt-get update
RUN apt-get install -y git python-pip python-dev build-essential
COPY requirements.txt /opt/data
RUN pip install -r /opt/data/requirements.txt

ENTRYPOINT ["mkdocs"]
