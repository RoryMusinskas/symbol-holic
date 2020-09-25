module StringGenerator
  SYMBOLS = ['#', '`', '%', '&', '[', '{', '}', '(', '=', '*', ')', '+', ']', '!', '|', '-', '_', '@', '^', '/', '?', '<', '>', '$', '~', ';', ':'].freeze
  def self.create_symbol_array
    randomized_array = []

    # choose a random symbol out of the array and append to a new array.
    rand(5).times do
      randomized_array << SYMBOLS.sample
    end
    # ensure that all elements in the array are unique
    randomized_array.uniq
  end

  def self.add_symbols_to_hash
    @combined_scores = {}
    SYMBOLS.each do |item|
      @combined_scores[item] = [0, 0, 0]
    end
    @combined_scores
  end
end
