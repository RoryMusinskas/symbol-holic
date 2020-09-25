require 'colorize'
require 'io/console'
require_relative 'string_generator'

class TypingGame
  include StringGenerator
  attr_reader :keypress_statistics
  def initialize
    # Used for testing with whole array
    @symbol_array = SYMBOLS
    # Commented out, trying with full array of symbols first to merge
    @symbol_array = StringGenerator.create_symbol_array
    @keypress_statistics = {}
  end

  # invoke the run of the game
  def run_game
    input
  end

  def words_per_min(first_time, second_time)
    @words_per_min = 60 / (second_time.round(1) - first_time.round(1))
  end

  def input
    @symbol_array.each do |item|
      @wrong_keys = 0
      print "#{item}  --->   "

      first_time = Time.now.to_f
      current_input = STDIN.getch

      while current_input != item
        current_input = STDIN.getch
        @wrong_keys += 1
      end

      second_time = Time.now.to_f if current_input == item
      puts current_input

      @accuracy = (1 / (1 + @wrong_keys.to_f) * 100)
      words_per_min(first_time, second_time)
      @keypress_statistics[item] = [@words_per_min, @accuracy, 1]
    end
    @keypress_statistics
  end
end
