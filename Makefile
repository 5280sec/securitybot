SLACK_API_TOKEN := "abc123"
DUO_INTEGRATION_KEY := "duointkey"
DUO_SECRET_KEY := "duoseckey"
DUO_ENDPOINT := "duoend"
REPORTING_CHANNEL := "repchan"
DB_HOST := "foobar"
DB_USER := "foobar"
DB_PASS := "foobar"
DB_NAME := "foobar"


########################################################################
##                          DOCKER BUILD                              ##
########################################################################
.PHONY: docker docker-clean

docker:
	docker build --pull -f Dockerfile -t securitybot .

docker-clean:
	docker rm --volumes --force `docker ps -qa` > /dev/null 2>&1 || true
	docker network prune --force || true

########################################################################
##                          SECURITY BOT                              ##
########################################################################
.PHONY: db bot frontend

bot:
	docker run \
	-e "PYTHONPATH=/securitybot" \
	-e "SLACK_API_TOKEN="${SLACK_API_TOKEN} \
	-e "DUO_INTEGRATION_KEY="${DUO_INTEGRATION_KEY} \
	-e "DUO_SECRET_KEY="${DUO_SECRET_KEY} \
	-e "DUO_ENDPOINT="${DUO_ENDPOINT} \
	-e "REPORTING_CHANNEL="${REPORTING_CHANNEL} \
	-e "DB_HOST="${DB_HOST} \
	-e "DB_USER="${DB_USER} \
	-e "DB_PASS="${DB_PASS} \
	-e "DB_NAME="${DB_NAME} \
	securitybot \
	python /securitybot/frontend/securitybot_frontend.py bot

frontend:
	docker run \
	-e "PYTHONPATH=/securitybot" \
	-e ${SLACK_API_TOKEN} \
	-e ${DUO_INTEGRATION_KEY} \
	-e ${DUO_SECRET_KEY} \
	-e ${DUO_ENDPOINT} \
	-e ${REPORTING_CHANNEL} \
	-e ${DB_HOST} \
	-e ${DB_USER} \
	-e ${DB_PASS} \
	-e ${DB_NAME} \
	securitybot \
	python /securitybot/frontend/securitybot_frontend.py frontend	