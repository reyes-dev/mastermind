# checks for matching type, matching position + type, full match
module Checkable
end
# computer generates/stores random 4-digit code 
# later a human can create the secret code 
module CodeGenerator
end
# displays board and hints each turn
# updates board with past plays 
class Board
end
# compares guess code to secret code
# end game if guess correct
# loop to new round if incorrect guess
# generates "white/red" hint pegs
# increments turn number 
# ends game after 12 turns
class GameLogic
  include Checkable
  include CodeGenerator
end
# runs the whole game
class Game < GameLogic
end