# mastermind
# Project Description: Build a Mastermind game from the command line where you have 12 turns to guess the secret code, starting with you guessing the computer’s random code.
# Parts of the game include: 
- 6 possible colors to make/guess the code with
- A secret code composed of 4 colors in a particular order (generated by Human Player and AI)
- 12 turns to win
- 4 slots for the player to place his guess (to match the secret code)
- 4 peg hint slots, 'Red' to show correct position/correct piece, 'White' to show correct piece/incorrect position (order of pegs is irrelevant)
# Notes:
-Separate game logic from other classes
-Separate GUI/board display logic
-Separate AI logic
-Separate hint peg slots logic
-Make sure hint logic matches guess 1:1 (I.E. if secret code has 1 'Red' peg and my guess has two 'Red' pegs, hint section should only return one 'White' peg)
-The hint pegs may be special characters
-Code can be any combination of the 6 colors (I.E. all blue, two red/two yellow, all different etc.)
-Colored text?
-Color pegs can be symbols, strings integers or special characters ('@', '$', '#', etc..)