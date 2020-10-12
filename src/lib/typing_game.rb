require 'colorize'
require 'json'
require 'io/console'
require_relative 'statistics_helper'

class TypingGame # include StatisticsHelper # Bring in the StatisticsHelper module
  # Initialize the typing game
  def initialize
    @symbol_array = StatisticsHelper.create_symbol_array
    @targeted_array = StatisticsHelper.randomized_targeted_array
    @keypress_statistics = {}
  end

  def test; end # Run the stardard typing game

  def run_game
    @symbol_array.each { |item| game_logic(item) }
    @keypress_statistics
  end

  # Run the targeted typing game
  def targeted_game
    @targeted_array.each { |item| game_logic(item) }
    @keypress_statistics
  end

  # Calculate the words per minute of each keypress the user types
  def words_per_min(first_time, second_time)
    words_per_min = 60 / (second_time - first_time)
    words_per_min
  end

  # Calculate the statistics to put into the hash, need to add the values each loop now that you can do multiple keys each run
  def calculate_statistics(item, wrong_keys, words_per_min)
    # If there is no value for the key in the hash, then add the current values in
    if @keypress_statistics[item].nil?
      # add the words per min, accuracy and 1 (for the amount of times the symbol has been shown)
      @keypress_statistics[
        item
      ] = [1, wrong_keys, words_per_min]
    else
      # Get the values in the hash and add the values to make a total to pass to the statistics
      symbol_count = @keypress_statistics[item][0] + 1
      wrong_keys_count = @keypress_statistics[item][1] + wrong_keys
      wpm_total = @keypress_statistics[item][2] + words_per_min

      @keypress_statistics[item] = [symbol_count, wrong_keys_count, wpm_total]
    end
  end

  # The logic for running the game
  def game_logic(item)
    wrong_keys = 0
    print "#{item}  --->   "

    # Get the time at the start of each loop
    first_time = Time.new.to_f # Get the current user input key, without having to press enter
    current_input = STDIN.getch

    # Until the user gets the right key, keep prompting them, add keep a total for the amount of wrong keys hit before the correct one
    while current_input != item
      print "#{current_input.colorize(:red)}, "
      current_input = STDIN.getch
      wrong_keys += 1
    end

    # Get the time when the user types the correct key
    second_time = Time.new.to_f if current_input == item
    puts current_input

    # Call and return the words per minute of each symbol
    # The game logic returns the calculated statistics of each key each loop
    calculate_statistics(
      item,
      wrong_keys,
      words_per_min(first_time, second_time)
    )
  end # Print each item from the generated symbol array
end
