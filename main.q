system"l common.q";
system"l game.q";

DEBUG_SKIP_CLS:0b;
DEBUG_NO_AUTO_START:0b;

FPS:2;            // Frames per second

currentScene:`game;
lastInput:"";


main:{[]
  system"echo ...";  // For ANSI escape codes (See .common.cls) to work for Windows CMD a batch command needs to be executed at least once beforehand, otherwise the escape character is displayed as a backwards arrow and they have no effect when printing

  `.z.pi set readInput;  // Setting .z.pi to the custom input-reading function (Best to assign it inside a function like this so as not to affect .z.pi if debugging with DEBUG_NO_AUTO_START)

  startScene[currentScene;()!()];
  startGameLoop[FPS];
 };

readInput:{[input]  // Function to replace .z.pi with once the main function executes. It reads the user's input, saves the last character to the lastInput variable and quits the game if special input is entered
  input:input except "\n";
  
  $[
    input~"";`lastInput set "";                               // i.e. User just pressed Enter without typing anything
    any like[input]each("*quit";"*exit");.common.quitGame[];  // If user types one of the special commands to exit
    `lastInput set lower last input                           // If the user did type something, save it to the lastInput variable
  ];
 };

startScene:{[scene;args]  // Used to switch to a new scene/level, pass args as a dictionary (Pass empty if no need for them)
  `currentScene set scene;
  value(`$".",string[currentScene],".start";args);
 };

startGameLoop:{[fps]               // Queues the gameLoop function to run at the specified frames per second
  `.z.ts set {.Q.trp[gameLoop;0;{  // Using .Q.trp to ensure that the game loop is error trapped with a detailed error log if one does occur
        2@"Error: ",x,"\nBacktrace:\n",.Q.sbt y;
        exit 1
      }
    ]
  };

  value"\\t ",string ceiling 1000%fps;  // Starting the loop ('\t X' requires X to be a time an integer amount of milliseconds)
 };

gameLoop:{[]
  process lastInput;
  draw[];

  `lastInput set "";
 };

process:{[input]  // Runs the process function for the current scene/level, passing in the user's input this frame as an argument
  value(`$".",string[currentScene],".process";input);
 };

draw:{[]         // Runs the draw function for the current scene/level
  value(`$".",string[currentScene],".draw";());
  1"[qSnake] ";  // Drawing the global prompt (Can remove this if you like or have the prompt be controlled by the current level's draw function nstead)
 };

if[not DEBUG_NO_AUTO_START;main[]];
