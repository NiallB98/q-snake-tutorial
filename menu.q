MENU_LEVEL:"\n" sv read0`:menu.txt;
MENU_OPTIONS:`play`quit;

.menu.cursorIndex:0;


.menu.start:{[args]
  `.menu.cursorIndex set 0;
 };

.menu.process:{[input]
  .menu.inputLogic input;
 };

.menu.draw:{[]
  lvl:MENU_LEVEL;

  lvl:.menu.drawCursor[lvl;.menu.cursorIndex];

  .common.cls[];
  -1 lvl;
 };

.menu.inputLogic:{[input]
  if[input~"";:()];

  $[
    input~"w";.menu.moveCursor 1b;  // Moves the cursor up if user inputs "w"
    input~"s";.menu.moveCursor 0b;  // Moves the cursor down if the user inputs "s"
    input~"e";.menu.selectOption MENU_OPTIONS .menu.cursorIndex;  // Selects the current option the cursor is pointing at if the user enters "e"
    ()
  ];
 };

.menu.drawCursor:{[lvl;cursorIndex]
  // [Step 1]
  // Modify lvl such that the two "@" symbols beside the currently selected menu option
  // are replaced with some indicator that they are the selected ones
  // and that the other "@" symbols in lvl are replaced with empty spaces
  // i.e. if cursorIndex~0 then the level could look something like this once printed:
  // +--------------------+
  // |                    |
  // |       qSnake       |
  // |                    |
  // |                    |
  // |                    |
  // |                    |
  // |      > PLAY <      |
  // |        Quit        |
  // |                    |
  // |                    |
  // |                    |
  // |                    |
  // +--------------------+
  // And would look like this if cursorIndex~1:
  // +--------------------+
  // |                    |
  // |       qSnake       |
  // |                    |
  // |                    |
  // |                    |
  // |                    |
  // |        PLAY        |
  // |      > Quit <      |
  // |                    |
  // |                    |
  // |                    |
  // |                    |
  // +--------------------+

  :lvl;
 };

.menu.moveCursor:{[moveUp]
  // [Step 2]
  // Add logic so that depending on whether moveUp is true or not, .menu.cursorIndex
  // is shifted by -1 or +1 and that it stays within 0 to (count[MENU_OPTIONS]-1) inclusive
 };

.menu.selectOption:{[option]
  // [Step 3]
  // Add logic so that:
  // if option~`play -> the `game scene/level is started
  // else if option~`quit -> execute .common.quitGame[]
 };
