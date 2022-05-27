module CodeGenerator
  def generate(array)
    array.each_index { |idx| array[idx] = rand(1..6) }
  end

  def modify_guess(array, enemy_array)
    array.each_index do |idx|
      unless array[idx] == enemy_array[idx]
        array[idx] = rand(1..6)
      end
    end
  end
end

module Checkable
  def match_type_position
    @human_array.each_index do |idx|
      if @human_array[idx] == @comp_array[idx]
        @hints[@round].push('★')
        @comp_array[idx] = nil
        @human_array[idx] = 'full'
      end
    end
  end

  def match_type
    @human_array.each_with_index do |num, idx|
      if @comp_array.any?(num)
        @hints[@round].push('☆')
        @comp_array[@comp_array.find_index { |e| e == num }] = nil
        @human_array[idx] = 'full'
      end
    end
  end

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

  def equalize_codes
    @comp_array.concat(@comp_code)
    @human_array.concat(@human_code)
  end

  def clear_codes
    @comp_array.clear
    @human_array.clear
  end

  def input_code
    loop do
      puts "Enter a 4-digit code of numbers 1-6"
      @human_code = gets.chomp.split('').map(&:to_i)
      break if @human_code.join.match?(/^[1-6]{4}$/)
    end
  end

  def update_board(guesser_code)
    @board_array[@round].replace(guesser_code)
  end
end

class Game < GameLogic
  def initialize
    super
  end

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

  def choose_mastermind
    loop do
      puts "Enter 1 to be the Mastermind | Enter 2 for AI Mastermind"
      @mm_choice = gets.chomp.split('').map(&:to_i)
      @mm_choice == [2] ? self.play_human : @mm_choice == [1] ? self.play_computer : "Wrong"
      break if @mm_choice.join.match?(/^[1-2]{1}$/)
    end
  end
end

my_game = Game.new.choose_mastermind