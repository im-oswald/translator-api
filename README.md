
# README

## Translator API

Backend API only Rails application to entertain glossary, terms and highlighting them in given text

### Development Setup
- Ruby version 2.7.1
- Rails version 7.0.3
### System Level Dependencies:
- PostgreSQL 14.2
### Project Level Dependencies
```
bundle install
```
### Setting up the Database
```
rails db:create
```
```
rails db:migrate
```
```
rails db:seed
```
### Start the Rails Server
```
rails server
```
### Running Tests
```
bundle exec rspec --format documentation
```
## Setting up the Project in Dockerized Environment
- Docker should be installed on system. Then run following commands:

```
docker-compose build
```
```
docker-compose up -d
```
```
docker exec -it translator-api_web_1 bundle exec rails db:setup
```
```
docker exec -it translator-api_web_1 bundle exec rails db:migrate
```
