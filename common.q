.common.quitGame:{[]
  .common.cls[];
  -1"Thanks for playing!";
  exit 0;
 };

.common.cls:{[]  // Clears the game screen using ANSI Escape codes
  $[
    DEBUG_SKIP_CLS;-1"\nDEBUG Cleared Screen";
    USE_ANSI_CLS;1"\033[H\033[2J\033[3J";  // Uses 3 ANSI escape codes: 1st is to move the cursor to the home position (0, 0); 2nd is to clear the entire screen; and 3rd is to erase saved lines
    -1"",100#"\n"                          // Prints 100 newlines
  ];
 };
