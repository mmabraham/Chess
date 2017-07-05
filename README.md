# Chess
##### The all-time classic written for the command line
play with a friend, against one of the custom built ai engines or watch the different ai algorithms compete.

![screen shot](screen_shot_small.png)

## Installation
- download zip or
`git clone https://github.com/mmabraham/Chess`
`bundle install`
`ruby chess.rb`
- player configuration can be edited within the script at the bottom of `chess.rb`
- difficulty can be changed by editing the `MAX_DEPTH` constant in the desired ai file.

## Game play
- use the arrow keys or w s a d to move the cursor.
- space or enter to select or drop a playing piece.

## Features
- Two custom built ai engines of various difficulty
- Both use a min-max algorithm by interpreting into a single score the board layout that would result from every valid move.
- DFSPlayer internally creates a tree depth first, up to the desired depth. It then immediately sets the score for each node.
- BFSPlayer creates the tree breadth first, potentially allowing it to run on a concurrent thread while waiting for the opponent's input and looking up scores only when required to move.

## Implementation
- Every player class has the same API allowing the game to interact with all players polymorphically.
- Uses modules to extract methods common to several types of pieces and keep the code DRY. i.e. queen, rook and bishop include the steppable module.
