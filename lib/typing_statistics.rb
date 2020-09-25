require_relative 'typing_game'
require_relative 'string_generator'
require 'terminal-table'

class TypingStatistics
  include StringGenerator

  def self.stats(scores, times_played)
    @combined_scores = StringGenerator.add_symbols_to_hash if times_played == 1
    scores.each do |key, val|
      # Storing the average WPM to the hash
      @combined_scores[key][0] = ((@combined_scores[key][0] + val[0]) / (@combined_scores[key][2] + val[2]))
      # Storing the average accuracy to the hash
      @combined_scores[key][1] = ((@combined_scores[key][1] + val[1]) / (@combined_scores[key][2] + val[2]))
      # Storing the amount of times each symbol has been displayed
      @combined_scores[key][2] = (@combined_scores[key][2] + val[2])
    end
    @combined_scores
  end

  def self.display_scores
    # p @combined_scores
    hash_to_array
  end

  def self.hash_to_array
    @rows = []
    @combined_scores.each do |key, val|
      @rows << [key, val[0], val[1], val[2]]
      @rows << :separator
    end
    table = Terminal::Table.new headings: ['Symbol', 'Average WPM', 'Average Accuracy', 'Symbol Count'], rows: @rows
    puts table
  end
end
