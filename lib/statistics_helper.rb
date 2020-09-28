require 'byebug'
require_relative 'typing_statistics'

module StatisticsHelper
  # An array of all the symbols to be availble to the user
  SYMBOLS = ['#', '`', '%', '&', '[', '{', '}', '(', '=', '*', ')', '+', ']', '!', '|', '-', '_', '@', '^', '/', '?', '<', '>', '$', '~', ';', ':'].freeze

  # create a randomized array of symbols to guess
  def self.create_symbol_array
    randomized_array = []

    # choose a random symbol out of the array and append to a new array.
    15.times do
      randomized_array << SYMBOLS.sample
    end
    # ensure that all elements in the array are unique
    randomized_array
  end

  # This is a method to get the last 8 keys from the user to make into a new array for targeted practice
  def self.create_targeted_array
    worst_key_array = []
    # Read the users statistics from the file
    typing_statistics = TypingStatistics.new.read_statistics
    # Get the last 8 hash elements (The users worst keys), by revesing hash and getting the first 8 elements
    worst_keys = typing_statistics.reverse_each.to_h.first(8)
    worst_keys.each do |key|
      worst_key_array << key[0]
    end
    worst_key_array
  end

  # This method creates a randomized array with the worst 8 keys, all represented 3 times and shuffled.
  def self.randomized_targeted_array
    randomized_array = []
    3.times do
      randomized_array << create_targeted_array.shuffle
    end
    randomized_array.flatten
  end

  # This is called when there is no data stored in the JSON file. It outputs a hash with all the symbols and sets all values to 0
  def self.add_symbols_to_hash
    typing_statistics = {}
    SYMBOLS.each do |item|
      typing_statistics[item] = [0, 0, 0, 0, 0]
    end
    typing_statistics
  end
end
