# computer generates/stores random 4-digit code 
# later a human can create the secret code 
module CodeGenerator
  def generate(array)
    array.each_index { |idx| array[idx] = rand(1..9)}
  end
end
# checks matching type, matching position + type, full match
module Checkable
end
# displays board and hints each turn
# updates board with past plays 
class Board
  attr_accessor :board_array, :board
  # makes empty array
  # changes made to array don't affect string variable board 
  def initialize
    @board_array = Array.new(12) { Array.new(4, '?') }
  end
  # this merely displays the array in string form 
  def board_setup
    @board = ''

    @board_array.each_index do |idx|
      @board.concat("   #{@board_array[idx].join(' | ')}\n")
      @board.concat("   --------------\n") 
    end
  end

  def board_display
    puts @board
  end
end
# takes input
# compares input to secret code
# end game if guess correct
# loop to new round if incorrect guess
# generates "white/red" hint pegs
# increments turn number 
# ends game after 12 turns
class GameLogic
  attr_accessor :secret_code

  include CodeGenerator
  include Checkable

  def initialize
    @secret_code = generate(Array.new(4))
  end
end
# runs the whole game
class Game < GameLogic
  def initialize
    super
  end
end

my_game = Game.new
print my_game.secret_code
