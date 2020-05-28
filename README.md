# README
[![ruby](https://img.shields.io/badge/ruby-v2.6.3-red.svg)](https://www.ruby-lang.org/en/)
[![rails](https://img.shields.io/badge/rails-v6.0.3-orange.svg)](https://rubyonrails.org/)

## Description/Purose

This is a Rails API to play the classic game Battleship&reg; for 412FoodRescue.

In it, 2 users, once registered can play against each other in alternating turns. 
The flow goes like so:
  * Users register and log in.
  * A game is created with 2 user's ids
  * They each place their ships and then take turns firing
  * Once a player has sunk all of their opponent's ships, they(the player) wins
  
 ## Endpoints
 
 ##### Base URLS
   * Base URL
     * `https://battleship412.herokuapp.com`
   * Base API URL
     * `https://battleship412.herokuapp.com/api`

##### Authentication
`POST /v1/user`
> Creates the user record in the database, using the following params:
```json
 {
      "status": 200,
      "message": null,
      "user": {
          "id": 4,
          "email": "email10@email.com",
          "first_name": "Testing",
          "last_name": "McTesterson"
      }
  } 
 ```

`POST /oauth/token`
> Logs the user in to the system, receiving an an access token that is required for all subsequent requests
```json
{
    "access_token": "access-token",
    "token_type": "Bearer",
    "expires_in": 7200,
    "created_at": 1590695530
}
```

##### Game Play

`POST /v1/games`
> Using 2 user ids, we are able to create a game
```json
{
  "game": {
    "player_1_id": 1,
    "player_2_id": 2
  }
}
```

`POST /v1/users/:user_id/games/:game_id/ship_placement`
> Places ships by submitting coordinates for each ship in the following format
```json
{
  "ships": {
      "patrol": ["A1"],
      "cruiser": ["B1", "B2"],
      "submarine": ["C1","C2", "C3"],
      "battleship": ["D1", "D2", "D3", "D4"],
      "carrier": ["E1", "E2", "E3", "E4", "E5"]
  }
}
```

`PATCH /v1/users/:user_id/games/:game_id/firing_solution`
> Taking turns, each player will submit a plot point in the hopes of hitting one their opponent's ships
>
>This flow will continue until all of one player's ships are sunk.

```json
{ 
  "shot": { 
    "coord": "A1" 
  }
} 
```

### API response
> The api will respond with two boards for each player. One for tracking the state of their ship placement and the 
>other to track the state of their shots. Also, a players 'ship' board will track hits and misses as well as whether or not
>the cell is occupied.

```json
{
  "status": 200,
  "message": nil,
  "game": {
    {
      "id": 1,
      "boards": {[
        {
          "id": 1,
          "board_type": "ships",
          "cells": [
              {
                "id": 1,
                "column": "A",
                 "row": "1",
                 "ship": {// The ship object will be nill if there is no ship occupying the cell
                    "id": 1,
                    "ship_type": "patrol"
                  },
                  "status": "occupied" //will result in either ["occupied","unoccupied", "hit", "miss"]      
              },
          ],
          "player": {
            "id": 1,
            "first_name": "Test",
            "last_name": "McTesterson"
          },
          "sunken_ships": {
            // This will contain an objectdenoting whether if any of the ships have been sunk
            {"patrol": true, "cruiser": false, "submarine": false, "battleship": false, "carrier": false}
          }           
        }
      ]},
      ...
      winner: nil,//will remain null until a winner is declared otherwise it will be a user object with the player's information
      loser nil //same as winner but with the loser
    },
    player_1: {..},//Player information
    player_2: {..}//Player information
  }
}
```