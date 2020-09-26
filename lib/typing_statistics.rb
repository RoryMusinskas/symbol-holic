require 'json'
require 'terminal-table'
require_relative 'typing_game'
require_relative 'string_generator'
require 'byebug'
class TypingStatistics
  # Bring in the string generator module
  include StringGenerator

  # The method for taking in the score of the game that the user just played
  # It then inputs the score into the average statistics for the user
  def statistics(scores)
    # If there is already a hash in the JSON File, then read it or else create a new blank hash (Will only be first time user runs game)
    begin
      read_statistics
    rescue StandardError
      # Create an empty hash so the score can be appended to it, as it will be nil otherwise and throw an error
      @averaged_statistics = StringGenerator.add_symbols_to_hash if @averaged_statistics.nil?
    end

    # Take the scores hash of the last completed typing game and append them to the averaged_statistics hash
    scores.each do |key, val|
      # Storing the amount of times each symbol has been displayed to the averaged hash
      @averaged_statistics[key][0] = @averaged_statistics[key][0] + val[0]
      # Storing the total amount of errors the user has made
      @averaged_statistics[key][1] = @averaged_statistics[key][1] + val[1]
      # Storing the average accuracy for the user
      @averaged_statistics[key][2] = @averaged_statistics[key][0] / (@averaged_statistics[key][0] + @averaged_statistics[key][1]).to_f
      # Storing the average WPM to the averaged hash
      @averaged_statistics[key][3] = ((@averaged_statistics[key][3] + val[2]) / (@averaged_statistics[key][0]))
    end
    # Write the statistics at the end of each game into the JSON file
    write_statistics(@averaged_statistics)
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
    @averaged_statistics.each do |key, val|
      @rows << [key, val[3], val[2], val[0], val[1]]
      # @rows << [key, val[0], val[1], val[2], val[3]]
      @rows << :separator
    end
    table = Terminal::Table.new headings: ['Symbol', 'Average WPM', 'Average Accuracy', 'Symbol Count', 'Errors'], rows: @rows
    puts table
  end
end
