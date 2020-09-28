require 'json'
require 'terminal-table'
require 'colorize'
require_relative 'typing_game'
require_relative 'statistics_helper'
require 'byebug'
class TypingStatistics
  # The method for taking in the score of the game that the user just played
  # It then inputs the score into the average statistics for the user
  def statistics(scores)
    # If there is already a hash in the JSON File, then read it or else create a new blank hash (Will only be first time user runs game)
    begin
      read_statistics
    rescue JSON::ParserError
      # Create an instanced empty hash so the score can be appended to it, as it will be nil otherwise and throw an error
      @averaged_statistics = StatisticsHelper.add_symbols_to_hash if @averaged_statistics.nil?
    end

    # Take the scores hash of the last completed typing game and append them to the averaged_statistics hash
    scores.each do |key, val|
      # Storing the amount of times each symbol has been displayed to the averaged hash
      @averaged_statistics[key][0] = total_count(@averaged_statistics[key][0], val[0])
      # Storing the total amount of errors the user has made
      @averaged_statistics[key][1] = total_count(@averaged_statistics[key][1], val[1])
      # Storing the average accuracy for the user
      @averaged_statistics[key][2] = average_accuracy(@averaged_statistics[key][0], @averaged_statistics[key][1])
      # Storing the total wpm
      @averaged_statistics[key][3] = total_count(@averaged_statistics[key][3], val[2])
      # Storing the average WPM to the averaged hash
      @averaged_statistics[key][4] = average_wpm(@averaged_statistics[key][3], @averaged_statistics[key][0])
    end
    # Write the statistics at the end of each game into the JSON file
    write_statistics(sort_averaged_statistics)
  end

  # Sort the users average scores by adding the average speed and accuracy, this is the indication of a good key
  def sort_averaged_statistics
    # This converts the hash into a sorted array
    sorted_array = @averaged_statistics.sort_by { |_key, val| -(val[2] + val[4]) }
    # Convert the array back to a hash for processing
    @averaged_statistics = sorted_array.to_h
  end

  # Total counter method to assist with setting the key values
  def total_count(total, addition)
    total += addition
    total
  end

  # Average accuracy method to assist with setting the key values
  def average_accuracy(total_symbol_count, total_error_count)
    ((total_symbol_count / (total_symbol_count + total_error_count).to_f) * 100).round(1)
  end

  # Average Words Per Minute method to assist with setting the key values
  def average_wpm(total_wpm, total_symbol_count)
    (total_wpm / total_symbol_count).round(1)
  end

  # Used for getting the absolute file path, wherever the user is. For when the user runs program from anywhere.
  def file_path
    path = File.dirname(__FILE__).split('/')
    path.pop
    json_file = "#{path.join('/')}/public/key_scores.json"
    json_file
  end

  # Read and parse the averaged_statistics hash from the JSON file
  def read_statistics
    file = File.read(file_path)
    @averaged_statistics = JSON.parse(file)
  end

  # Write the averaged_statistics hash to the JSON file
  def write_statistics(averaged_statistics)
    File.write(file_path, JSON.pretty_generate(averaged_statistics))
  end

  # Display the statistics in a terminal table, for the users to read.
  def display_statistics
    # Read the current JSON file to get the averaged_statistics hash
    read_statistics
    # Make a terminal table and add in values from averaged_statistics hash
    @rows = []
    counter = 0
    @averaged_statistics.each do |key, val|
      # Set the color of the symbol to red if the users accuracy is less than 60
      val[2] = val[2].to_s.colorize(:red) if val[2].positive? && val[2] < 60
      # Add each symbol and associated data to the terminal-table row
      @rows << [key, val[4], val[2], val[0]]
      counter += 1
      # Print a seperator for each symbol apart from the last
      @rows << :separator if counter < @averaged_statistics.size
    end
    table = Terminal::Table.new title: 'Your Typing Statistics', headings: ['Symbol', 'Average WPM', 'Average Accuracy %', 'Symbol Count'], rows: @rows
    puts table
  end

  # The method for wiping the JSON file if the user wants to.
  def wipe_file
    File.truncate(file_path, 0)
  end
end
