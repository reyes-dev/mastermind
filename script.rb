module CodeGenerator
  # create a random secret code to solve
  def generate(array)
    array.each_index { |idx| array[idx] = rand(1..6) }
  end
  # lets the cpu guess a new number every round
  def modify_guess(array, enemy_array)
    array.each_index do |idx|
      unless array[idx] == enemy_array[idx]
        array[idx] = rand(1..6)
      end
    end
  end
end

module Checkable
  # check to see if your guess matches both position and number
  def match_type_position
    @human_array.each_index do |idx|
      if @human_array[idx] == @comp_array[idx]
        @hints[@round].push('★')
        @comp_array[idx] = nil
        @human_array[idx] = 'full'
      end
    end
  end
  # check to see if your guess only matches a number
  def match_type
    @human_array.each_with_index do |num, idx|
      if @comp_array.any?(num)
        @hints[@round].push('☆')
        @comp_array[@comp_array.find_index { |e| e == num }] = nil
        @human_array[idx] = 'full'
      end
    end
  end
  # check if both codes match completely
  def match_full
    if @human_code == @comp_code
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
  # creates a display board of array type
  def initialize
    @board_array = Array.new(12) { Array.new(4, '?') }
  end
  # prepares the board to be displayed, converted to string with hints
  def board_setup
    @board = ''

    @board_array.each_index do |idx|
      @board.concat("   #{@board_array.reverse[idx].join(' | ')}  Hints: #{@hints.reverse[idx]} \n")
      @board.concat("   --------------\n") 
    end
  end
  # displays the board
  def board_display
    self.board_setup
    puts @board
  end
end

class GameLogic < Board
  attr_accessor :comp_code, :game_over, :human_code, :round, :hints, :comp_array, :human_array, :mm_choice

  include CodeGenerator
  include Checkable

  def initialize
    super
    @comp_code = generate(Array.new(4) { Array.new })
    @hints = Array.new(12) { Array.new }
    @game_over = false
    @round = 0
    @comp_array = []
    @human_array = []
  end
  # adds the codes to array in order to check equivalence every round
  def equalize_codes
    @comp_array.concat(@comp_code)
    @human_array.concat(@human_code)
  end
  # clears out codes before the round ends so they can be concatenated anew
  def clear_codes
    @comp_array.clear
    @human_array.clear
  end
  # Takes input only of a 4-digit code of digits between numbers 1-6
  def input_code
    loop do
      puts "Enter a 4-digit code of numbers 1-6"
      @human_code = gets.chomp.split('').map(&:to_i)
      break if @human_code.join.match?(/^[1-6]{4}$/)
    end
  end
  # updates the board display each round with the guessed code for that turn
  def update_board(guesser_code)
    @board_array[@round].replace(guesser_code)
  end
end

class Game < GameLogic
  def initialize
    super
  end
  # calls methods to have the human player guess the code
  def play_human
    puts "AI is Mastermind"
    until game_over || @round > 11
      self.board_display
      self.input_code
      self.equalize_codes
      self.update_board(@human_code)
      self.check_all
      self.clear_codes
      self.round += 1
    end
    self.board_display
    puts "\n The secret code was: #{self.comp_code} \n"
  end
  # calls methods to have the human player create the code that the cpu then guesses
  def play_computer
    puts "You are the Mastermind"
    self.input_code
    until game_over || @round > 11
      puts "Your secret code is: #{self.human_code}"
      self.board_display
      self.modify_guess(@comp_code, @human_code)
      self.update_board(@comp_code)
      self.match_full
      self.round += 1
      puts "==========================="
    end
    self.board_display
    puts "\n The final AI guess was: #{self.comp_code} \n"
  end
  # loop to choose who the mastermind will be
  def choose_mastermind
    loop do
      puts "Enter 1 to be the Mastermind | Enter 2 for AI Mastermind"
      @mm_choice = gets.chomp.split('').map(&:to_i)
      if @mm_choice == [2] 
        self.play_human 
      elsif @mm_choice == [1] 
        self.play_computer 
      else 
        "Wrong"
      end
      break if @mm_choice.join.match?(/^[1-2]{1}$/)
    end
  end
end

my_game = Game.new.choose_mastermind