# Kanban Board

## Resources
1. Users
    * Users have those attributes: (email, password, username).	
    * A user can be of two types, either a ‘Member’ or an ‘Admin’.
    * **EndPoints:**
        * Authentication: Sign-up / Login
        * Get all Users

2. Lists
    * A List is composed of title, and cards.
    * Each list has many cards.
    * **EndPoints:**
        * Index
        * Show: Return the list with the cards in it.
        * Create
        * Update
        * Delete
        * Assign_member
        * Un-Assign_membe


3. Cards
    * The Card consists of title, description, and comments.
    * cards should be ordered by the count of the main comments (not replies) it have.
    * **EndPoints:**
        * Index: should respect the order mentioned above.
        * Show: Return the cards with the first 3 comments in it.
        * Create
        * Update
        * Delete


4. Comments
    * Comment compose of only content and replies (comments).
    * Users should be able to leave comments on Cards or reply on other comments and replies.
    * **EndPoints:**
        * Index: Get the comments created on a certain resource -Card/other Comment- with pagination.
        * Show: Return the comment with all the replies on it.
        * Create: Create a new comment/reply on a certain resource -Card/other Comment-.
        * Update
        * Delete



## Admin actions
  * List: Can create lists, Can remove/update his own lists, Can read all lists.
  * Card: Can Create Cards on any list, Can remove/update his own cards and any other card in his own lists, can read all cards
  * Comments: Can update/remove his own comments and any other comment on his own lists, Can create a comment any where, can read all comments
  * Member: can assign/unassign members on his own lists

## Member actions
  * List: can access only lists assigned to him
  * Cards: Can create a card on his lists, can read all cards on his lists, can update/remove his own cards
  * Comments: can create comment on any card or reply to comments in his lists, can read all comments on his lists , can remove his own comments including other people’s replies on it , can update his comments/replies


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

2. Token based authentication is implemented manually.

    * User can login only from one device he has only one token.
    * Token is expired every certin time (default 1 week ) and login is needed.
    * no refresh token implemented for simplicity

3. Redis is used to enhance project performance
    * User token saved in cache for fast authentication as every request will need to access the token
    * Used in index cards based on number of comments it has ( returns set of the ids of cards inside this list sorted based on number of comments so database query will be just selecting using ID which is indexed so it's much faster) 

4. Pagination is implemented manually using offset and limit instead of using gem

## Tests

Integration Tests and model tests are partially implemented more tests need to be added

