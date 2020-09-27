module StringGenerator
  # An array of all the symbols to be availble to the user
  SYMBOLS = ['#', '`', '%', '&', '[', '{', '}', '(', '=', '*', ')', '+', ']', '!', '|', '-', '_', '@', '^', '/', '?', '<', '>', '$', '~', ';', ':'].freeze

  # create a randomized array of symbols to guess
  def self.create_symbol_array
    randomized_array = []

    # choose a random symbol out of the array and append to a new array.
    rand(5).times do
      randomized_array << SYMBOLS.sample
    end
    # ensure that all elements in the array are unique
    randomized_array.uniq
  end

  # This is called when there is no data stored in the JSON file. It outputs a hash with all the symbols and sets all values to 0
  def self.add_symbols_to_hash
    @combined_scores = {}
    SYMBOLS.each do |item|
      @combined_scores[item] = [0, 0, 0, 0, 0]
    end
    @combined_scores
  end
end
