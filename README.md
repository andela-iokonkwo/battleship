# Battleship

This project is an implementation of the classic game Battleship.

## Introduction

### Building the game

To build the game, run:

```
mix escript.build
```

### Starting a Game

The player starts the game by running
```
./battleship
```
Then they see:

```
Welcome to BATTLESHIP
Would you like to (p)lay, read the (i)nstructions, or (q)uit?
>
```
- If they enter p or play then they enter the ship layout described below.
- If they enter i or instructions they should be presented with a short explanation of how the game is played.
- If they enter q or quit then the game should exit
Ship Layout

Once the user starts a game they should see:

```
I have laid out my ships on the grid.
You now need to layout your two ships.
The first is two units long and the
second is three units long.
The grid has A1 at the top left and D4 at the bottom right.
Enter the squares for the two-unit ship:
Then they enter coordinates like this: A1 A2
```

Which places the two element ship on squares A1 and A2. Then it asks for the coordinates for the three-unit ship.

**Note that:**

- Ships cannot wrap around the board
- Ships cannot overlap
- Ships can be laid horizontally or vertically
- Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at "A1 A3")
Then they enter the game flow sequence.

### Game Flow

Once the ships are laid out the game starts with the Player Shoots Sequence.

#### Player Shoots Sequences

The game first outputs a map:

```
Your turn! Here's what you know:
===========
. 1 2 3 4
A
B
C
D
===========
Enter a coordinate to shoot at:
```

Then they enter a coordinate:

- If the coordinate has already been shot at, reject the guess and ask them to shoot again
- If the coordinate misses the opponent ships, mark it with an O on the map.
- If the coordinate "hits" an opponent ship, mark it with an H on the map and enter the `Hit Ship sequence` below.

Then move to the Enemy Shoots sequence.

### Enemy Shoots Sequence

```
My turn! Here's your map:
===========
. 1 2 3 4
A X X
B     Y
C     Y
D     Y
===========
```
Where XX and YYY represent the player’s ships.

The computer player randomly selects a location which has not been shot at and shoots at it.
- If the shot misses the player ships, mark it with a M on the map.
- If the shot "hits" a player ship, mark it with an H on the map and enter the Hit Ship sequence.

Then move to the `Player Shoots sequence`.

### Hit Ship Sequence

- If the hit did not sink the ship, tell them that they hit an enemy ship
- If the hit sunk the ship, tell them they sunk it and the size of the ship.
- If the hit sunk the ship and it was the last enemy ship, then enter the `End Game sequence`

### End Game Sequence

When either the player or computer wins the game…

- Output a sorry/congratulations message
- Output how many shots it took the winner to sink the opponent’s ships
- Output the total time that the game took to play

## Extensions

The following extensions are added as part of the battleship game implementation:

### Difficulty Levels

When the user is getting ready to start a game, ask them what difficulty level they’d like to play with the following adaptations:

- Beginner = 4x4 grid, 2-unit boat, 3-unit boat
- Intermediate = 8x8 grid, 2-unit boat, 3-unit boat, 4-unit boat
- Advanced = 12x12 grid, 2-unit boat, 3-unit boat, 4-unit boat, 5-unit boat

### Remote Play

Allow two players to play against each other across the network.

### Graphical Interface

Use [seagull](https://github.com/andela-iokonkwo/seagull) to generate a graphical user interface that allows the players to see the game and click the grid to shoot.
