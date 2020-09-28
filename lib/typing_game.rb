require 'colorize'
require 'json'
require 'io/console'
require_relative 'statistics_helper'

class TypingGame
  # Bring in the StatisticsHelper module
  include StatisticsHelper

  # Initialize the typing game
  def initialize
    @symbol_array = StatisticsHelper.create_symbol_array
    @targeted_array = StatisticsHelper.randomized_targeted_array
    @keypress_statistics = {}
  end

  # Calculate the words per minute of each keypress the user types
  def words_per_min(first_time, second_time)
    @words_per_min = 60 / (second_time - first_time)
  end

  def run_game
    # Print each item from the generated symbol array
    @symbol_array.each do |item|
      game_logic(item)
    end
    @keypress_statistics
  end

  def targeted_game
    @targeted_array.each do |item|
      game_logic(item)
    end
    @keypress_statistics
  end

  # The logic for running the game
  def game_logic(item)
    @wrong_keys = 0

    print "#{item}  --->   "

    # Get the time at the start of each loop
    first_time = Time.new.to_f
    # Get the current user input key, without having to press enter
    current_input = STDIN.getch

    # Until the user gets the right key, keep prompting them, add keep a total for the amount of wrong keys hit before the correct one
    while current_input != item
      print "#{current_input.colorize(:red)}, "
      current_input = STDIN.getch
      @wrong_keys += 1
    end

    # Get the time when the user types the correct key
    second_time = Time.new.to_f if current_input == item
    puts current_input

    # Call and return the word per minute of each symbol
    words_per_min(first_time, second_time)
    # add the words per min, accuracy and 1 (for the amount of times the symbol has been shown)
    @keypress_statistics[item] = [1, @wrong_keys, @words_per_min]
  end
end
