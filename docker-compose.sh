#!/bin/bash

COMMAND=${1:-up}
container_name="grafica"

execute-docker-compose () {
  docker-compose \
    -f 'docker-compose.yml' \
    $@
}

execute-docker-sync () {
  docker-sync \
    $@ \
    -c 'docker-sync.yml'
}

stop-docker-compose () {
  execute-docker-sync stop
  execute-docker-compose stop
}

if [ $COMMAND = 'up' ] && [ $# -le 1 ]; then
  execute-docker-sync start
  execute-docker-compose up
  stop-docker-compose

elif [ $COMMAND = 'bash-g' ]; then
  execute-docker-compose exec $container_name /bin/bash

elif [ $COMMAND = 'grafica-reset-db' ]; then
  execute-docker-compose rm -f grafica-neo4j
  execute-docker-compose rm -f grafica-neo4j-test
  execute-docker-compose up -d
  echo "wait until server on neo4j-test available ..."
  sleep 20s
  execute-docker-compose exec grafica bundle exec rake neo4j:migrate RAILS_ENV=development
  execute-docker-compose exec grafica bundle exec rake neo4j:migrate RAILS_ENV=test
  execute-docker-compose stop

elif [ $COMMAND = 'bash-t' ]; then
  execute-docker-compose exec tienda /bin/bash

else
  execute-docker-compose $@
fi
