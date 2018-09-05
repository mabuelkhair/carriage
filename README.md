# Carriage

## Installation
First of all copy .env.example and name it .env (then set your environment values)

There are two options to run project

1. to install docker and docker compose then all you need to do is to run 
    ```docker-compose up```
    
2. to run it without docker you will need to have up & running redis server

    * set db_host in env to localhost
  
    * uncomment first line in config/initializer/redis.rb and comment second one

## Decisions
1. Docker Used to simplify the process of running the project and make it portable and simulate the same env the project developed on

2. Token based authentication is implemented manually (requirement: not to use extra gems).

    * User can login only from one device he has only one token when login the old one is destroied and the new one saved (to handle many login token all need is to create table token and relate user to it instead of token as field on user model)

    * Token is expired every certin time (default 1 week ) and login is needed 
    * no refresh token implemented for simplicity 

3. Redis is used to enhance project performance
    * User token saved in cache for fast auth as every request will need to access
    * Used in index cards based on number of comments it has ( returns set of the ids of cards inside this list sorted based on number of comments so database query will be just selecting using ID which is indexed so it's much faster) 

4. Pagination is implemented manually using offset and limit instead of using gem (requirement: not to use extra gems)

## Tests

Integration Tests and model tests are partially implemented more tests need to be added

