FROM python:2.7

COPY . /securitybot
RUN pip install -r /securitybot/requirements.txt
RUN useradd securitybot
USER securitybot
WORKDIR /securitybot