#!/bin/bash

COMMAND=${1:-up}
container_name="grafica"

function execute-docker-compose () {
  docker-compose \
    -f 'docker-compose.yml' \
    $@
}

function execute-docker-sync () {
  docker-sync \
    $@ \
    -c 'docker-sync.yml'
}

function stop-docker-compose () {
  # execute-docker-sync stop
  execute-docker-compose stop
}

if [ $COMMAND = 'up' ] && [ $# -le 1 ]; then
  # trap 'stop-docker-compose' SIGINT
  # execute-docker-sync start
  # execute-docker-compose up

  execute-docker-sync start
  execute-docker-compose up -d
  execute-docker-compose exec $container_name /bin/bash
  stop-docker-compose
elif [ $COMMAND = 'bash' ]; then
  execute-docker-compose exec $container_name /bin/bash

elif [ $COMMAND = 'reset-db' ]; then
  execute-docker-compose rm -f neo4j
  execute-docker-compose rm -f neo4j-test
  execute-docker-compose up -d
  echo "wait until server on neo4j-test available ..."
  sleep 20s
  execute-docker-compose exec grafica bundle exec rake neo4j:migrate RAILS_ENV=development
  execute-docker-compose exec grafica bundle exec rake neo4j:migrate RAILS_ENV=test
  execute-docker-compose stop

else
  execute-docker-compose $@
fi
