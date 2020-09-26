require 'colorize'
require 'json'
require 'io/console'
require_relative 'string_generator'

class TypingGame
  # Bring in the StringGenerator module
  include StringGenerator

  # Initialize the typing game
  def initialize
    @symbol_array = StringGenerator.create_symbol_array
    @keypress_statistics = {}
  end

  # Calculate the words per minute of each keypress the user types
  def words_per_min(first_time, second_time)
    @words_per_min = 60 / (second_time.round(1) - first_time.round(1))
  end

  # The logic for running the game
  def run_game
    # Print each item from the generated symbol array
    @symbol_array.each do |item|
      @wrong_keys = 0
      print "#{item}  --->   "

      # Get the time at the start of each loop
      first_time = Time.now.to_f
      # Get the current user input key, without having to press enter
      current_input = STDIN.getch

      # Until the user gets the right key, keep prompting them, add keep a total for the amount of wrong keys hit before the correct one
      while current_input != item
        current_input = STDIN.getch
        @wrong_keys += 1
      end

      # Get the time when the user types the correct key
      second_time = Time.now.to_f if current_input == item
      puts current_input

      # Get the accuracy of each symbol
      #      @accuracy = (1 / (1 + @wrong_keys.to_f) * 100)
      # Call and return the word per minute of each symbol
      words_per_min(first_time, second_time)
      # add the words per min, accuracy and 1 (for the amount of times the symbol has been shown)
      @keypress_statistics[item] = [1, @wrong_keys, @words_per_min]
    end
    @keypress_statistics
  end
end
