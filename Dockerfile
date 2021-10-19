FROM ubuntu:bionic

COPY . /securitybot
RUN apt update
RUN apt install -y libmysqlclient-dev python2.7 python-pip
#RUN ln -s /usr/include/mysql/mysql.h /usr/include/mysql/my_config.h
RUN pip install -r /securitybot/requirements.txt
RUN useradd securitybot
USER securitybot
WORKDIR /securitybot