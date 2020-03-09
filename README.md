# grafica

## Todos

## Notes

```
# to create new service
docker container run --rm -it -v $(pwd):/app ruby:2.6.5-buster /bin/bash
rails new ./services/[app-name] -T --api --skip-bundle [--database postgresql] [--skip-active-record]
cd ./services/[app-name]
bundle install
rails g rspec:install
bundle exec guard init rspec

# if mongoid
rails g mongoid:config
```
