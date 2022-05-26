# computer generates/stores random 4-digit code
# later a human can create the secret code
module CodeGenerator
  def generate(array)
    array.each_index { |idx| array[idx] = rand(1..6) }
  end
end
# checks matching type, matching position + type, full match
module Checkable
  def match_type
  end

  def match_position
  end
  # needs parameters?
  def match_full
    if @player_code == @secret_code
      @game_over = true
    end
  end
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
      @board.concat("   #{@board_array.reverse[idx].join(' | ')}\n")
      @board.concat("   --------------\n") 
    end
  end

  def board_display
    self.board_setup
    puts @board
  end
end
# takes input
# compares input to secret code
# end game if guess correct
# loop to new round if incorrect guess
# update board
# generate "white/red" hint pegs
# increment turn number
# ends game after 12 turns
class GameLogic < Board
  attr_accessor :secret_code, :game_over, :player_code, :round

  include CodeGenerator
  include Checkable

  def initialize
    super
    @secret_code = generate(Array.new(4))
    @game_over = false
    @round = 0
  end

  def guess_code
    loop do
      puts "Enter a 4-digit code of numbers 1-6"
      @player_code = gets.chomp.split('').map(&:to_i)
      break if @player_code.join.match?(/^[1-6]{4}$/)
    end
  end

  def update_board
    @board_array[@round] = @player_code
  end
end
# runs the whole game
class Game < GameLogic
  def initialize
    super
  end

  def play
    until game_over || @round > 11
      self.board_display
      self.guess_code
      self.update_board
      self.match_full
      self.round += 1
    end
    self.board_display
  end

end

my_game = Game.new.play