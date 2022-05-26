module CodeGenerator
  def generate(array)
    array.each_index { |idx| array[idx] = rand(1..6) }
  end
end

module Checkable
  def match_type_position
    @temp_code.each_index do |idx|
      if @temp_code[idx] == @temp_array[idx]
        @hints[@round].push('★')
        @temp_array[idx] = nil
        @temp_code[idx] = 'full'
      end
    end
  end

  def match_type
    @temp_code.each_with_index do |num, idx|
      if @temp_array.any?(num)
        @hints[@round].push('☆')
        @temp_array[@temp_array.find_index { |e| e == num }] = nil
        @temp_code[idx] = 'full'
      end
    end
  end

  def match_full
    if @player_code == @secret_code
      @game_over = true
    end
  end

  def check_all
    self.match_type_position
    self.match_type
    self.match_full
  end
end

class Board
  attr_accessor :board_array, :board

  def initialize
    @board_array = Array.new(12) { Array.new(4, '?') }
  end

  def board_setup
    @board = ''

    @board_array.each_index do |idx|
      @board.concat("   #{@board_array.reverse[idx].join(' | ')}  Hints: #{@hints.reverse[idx]} \n")
      @board.concat("   --------------\n") 
    end
  end

  def board_display
    self.board_setup
    puts @board
  end
end

class GameLogic < Board
  attr_accessor :secret_code, :game_over, :player_code, :round, :hints, :temp_array, :temp_code

  include CodeGenerator
  include Checkable

  def initialize
    super
    @secret_code = generate(Array.new(4))
    @temp_array = []
    @temp_code = []
    @game_over = false
    @round = 0
    @hints = Array.new(12) { Array.new }
  end

  def equalize_codes
    @temp_array.concat(@secret_code)
    @temp_code.concat(@player_code)
  end

  def clear_codes
    @temp_array.clear
    @temp_code.clear
  end

  def input_code
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

class Game < GameLogic
  def initialize
    super
  end

  def play
    until game_over || @round > 11
      self.board_display
      self.input_code
      self.equalize_codes
      self.update_board
      self.check_all
      self.clear_codes
      self.round += 1
    end
    self.board_display
    puts "\n The secret code was: #{self.secret_code} \n"
  end
end

my_game = Game.new.play