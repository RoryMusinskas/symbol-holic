require_relative '../lib/string_generator'

describe 'Create Symbol Array' do
  it 'should return an array that is not empty' do
    expect(StringGenerator.create_symbol_array.empty?).to be(false)
  end
  it 'should return an array of symbols that is the same length as the random number' do
    expect(StringGenerator.create_symbol_array.length).to be(15)
  end
  it 'should only have the provided symbols in the array' do
    def only_approved_symbols
      is_included = true
      StringGenerator.create_symbol_array.each do |item|
        is_included = false if StringGenerator::SYMBOLS.include?(item) == false
      end
      is_included
    end
    expect(only_approved_symbols).to be(true)
  end
end

describe 'Add empty hash to JSON file' do
  it 'should return a hash' do
    expect(StringGenerator.add_symbols_to_hash.empty?).to be(false)
  end
  it 'should return a hash with 27 keys' do
    expect(StringGenerator.add_symbols_to_hash.size).to be(27)
  end
  it 'should set the hash key values to an array with 5 elements' do
    expect(StringGenerator.add_symbols_to_hash['#'].length).to be(5)
  end
  it 'should set hash key elements to 0' do
    expect(StringGenerator.add_symbols_to_hash['#']).to eq([0, 0, 0, 0, 0])
    expect(StringGenerator.add_symbols_to_hash[':']).to eq([0, 0, 0, 0, 0])
  end
en