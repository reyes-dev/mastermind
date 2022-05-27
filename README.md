# mastermind
Project Description: Build a Mastermind game from the command line where you have 12 turns to guess the secret code, starting with you guessing the computer’s random code.
# Parts of the game include: 
- 6 possible numbers to make the guess code with
- A secret code composed of 4 numbers in a particular order (generated by Human Player or AI)
- 12 turns to win or the game ends
- 4 peg hint slots
- Hint '★' to show correct number/correct position, hint '☆' to show correct number/incorrect position (order of stars is irrelevant)
# About the gameplay:
AI Mastermind
- The AI generated secret code is completely random
- The board is updated each round with the guessed code
- The secret code is not revealed until the game is won or 12 rounds have passed

Human Mastermind
- Player is asked to input a 4 digit secret code #1-6
- AI will try to crack it by generating a random number
- If a digit matches one from the secret code in value and position it is kept, otherwise discarded
- AI wins if it matches all 4 digits before round 12 is over