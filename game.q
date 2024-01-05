GAME_GRID_WIDTH:10;
GAME_GRID_HEIGHT:10;

GAME_GRID_STATE_VISUALS:("  ";"[]";"()";"@@";"XX");                 // Visual representation of each state for each grid square (10x10 grid maps to a 20x10 character grid so each grid square is 2 characters wide)
GAME_GRID_STATES:`empty`snake`head`fruit`dead!0 1 2 3 4;            // Maps the names of each grid state to the index of its visual representation in GAME_GRID_STATE_VISUALS

GAME_LEVEL:"\n" sv read0`:game.txt;                                 // The level's text file loaded in as a string with \n separating each line

GAME_GRID_1D:(GAME_GRID_WIDTH*GAME_GRID_HEIGHT)#0;                  // The base game grid where index i = x + y * GAME_GRID_WIDTH
GAME_GRID_VISUAL_INDICES:raze{x+til 20}each ss[GAME_LEVEL;20#" "];  // Each index/square in GAME_GRID_1D maps to 2 indices in the game level, which is why this is 20 characters wide rather than 10

.game.snakePosList:`x`y!(enlist 4;enlist 2);                        // Dictionary mapping lists of x and y coordinates for the snake's body where the first x and y correspond to the snake's head
.game.snakeDir:`x`y!(0 -1);                                         // Relative position of the next grid square the snake will move to where positive/negative x is right/left and positive/negative y is down/up
.game.fruitPos:`x`y!(0 0);                                          // Position of the fruit on the game grid, randomised once .game.start is called

.game.score:0;                                                      // Current score
.game.hasLost:0b;                                                   // Whether the game has been lost or not


.game.start:{[args]  // Called once this level starts, used to initialise/reset the level's variables, etc. ("args" argument not used in this case but could be useful for some levels)
  `.game.snakePosList set `x`y!(enlist 4;enlist 2);
  `.game.snakeDir set `x`y!(0 1);
  .game.randomiseFruitPos[];

  `.game.score set 0;
  `.game.hasLost set 0b;
 };

.game.process:{[input]  // Called every frame in the gameLoop function before the drawing function if this level is active
  .game.inputLogic input;
  .game.gameLogic[];
 };

.game.draw:{[]  // Called every frame in the gameLoop function after the processing function if this level is active
  lvl:GAME_LEVEL;

  lvl:.game.drawGrid[lvl;GAME_GRID_1D;GAME_GRID_VISUAL_INDICES;.game.snakePosList;.game.fruitPos];
  lvl:.game.drawScore[lvl;.game.score];

  .common.cls[];
  -1 lvl;
 };

.game.inputLogic:{[input]  // Executes logic every frame based on the player's input
  if[input~"";:()];        // Returning early if no input this frame

  // [Step 6] Change snakeDir based on whether w/a/s/d are pressed with w = up, a = left, s = down, d = right
  // [Step 7] Restart the game if "r" is pressed (Hint: There is a function already you can call to do this)
 };

.game.gameLogic:{[]  // Executes game logic every frame
  if[.game.hasLost;:()];

  initialTailX:last .game.snakePosList`x;
  initialTailY:last .game.snakePosList`y;

  .game.moveSnake[];
  .game.eatFruit[initialTailX;initialTailY];
 };

.game.moveSnake:{[]
  // [Step 5]
  // Update the .game.snakePosList such that:
  // 1. The snake's head (the first x and y) moves in the direction of .game.snakeDir
  // 2. The rest of the snake's body (the rest of the x and y coords) follow the head
  //
  // 3. Check whether the snake's head is out of bound of the grid
  //    (Which has width 'GAME_GRID_WIDTH' and height 'GAME_GRID_HEIGHT')
  //    If so:
  //        Keep the snake in the position it was in before moving this frame
  //        Mark the game as lost by updating the .game.hasLost variable
 };

.game.eatFruit:{[initialTailX;initialTailY]
  // [Step 9] 
  // If the snake's grid positions overlaps with the fruit's grid positions:
  //     Increase the score
  //     Extend the snake (Hint: The arguments to this function may be useful)
  //     Execute '.game.randomiseFruitPos'
 };

.game.randomiseFruitPos:{[]
  // [Step 8]
  // Randomise .game.fruitPos's x and y's to a random point on the game grid
  // (Which has width 'GAME_GRID_WIDTH' and height 'GAME_GRID_HEIGHT')
  // Also make sure that the fruit's new position does not overlap with the snake's positions
 };

.game.drawGrid:{[lvl;grid1D;gridVisualIndices;snakePosList;fruitPos]
  // [Step 2] For the index for the position on the game grid where the fruit is located,
  // set that element of the grid1D to equal the number associated with fruit (See the GAME_GRID_STATES dictionary)

  // [Step 3] For the indices for the positions on the game grid where the snake's head and body are located,
  // set those positions to the correct game state value for the snake's head and body
  // (`head and `snake in the GAME_GRID_STATES dictionary respectively)

  // [Step 4] If the game is lost, instead of using the game state `head for the snake's head, use `dead (See the GAME_GRID_STATES dictionary)

  lvl[gridVisualIndices]:raze GAME_GRID_STATE_VISUALS grid1D;  // Maps the values for each element of grid1D to a pair of characters then assigns the corresponding elements of the game lvl that new character

  :lvl;
 };

.game.drawScore:{[lvl;score]
  // [Step 1] Replace the "XXXXXXXXXXX" in the lvl string with the .game.score, ensuring the string stays the same length

  :lvl;
 };
