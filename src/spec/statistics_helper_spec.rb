require_relative '../lib/statistics_helper.rb'

describe 'Create Symbol Array' do
  it 'should return an array that is not empty' do
    expect(StatisticsHelper.create_symbol_array.empty?).to be(false)
  end
  it 'should return an array of symbols that has 15 elements' do
    expect(StatisticsHelper.create_symbol_array.length).to be(15)
  end
  it 'should only have the provided symbols in the array' do
    def only_approved_symbols
      is_included = true
      StatisticsHelper.create_symbol_array.each do |item|
        is_included = false if StatisticsHelper::SYMBOLS.include?(item) == false
      end
      is_included
    end
    expect(only_approved_symbols).to be(true)
  end
end

describe 'It should create a targeted array' do
  it 'should return an array that is not empty' do
    expect(StatisticsHelper.create_targeted_array.empty?).to be(false)
  end
  it 'should return an array of symbols that has 8 elements' do
    expect(StatisticsHelper.create_targeted_array.length).to be(8)
  end
  it 'should only have the provided symbols in the array' do
    def only_approved_symbols
      is_included = true
      StatisticsHelper.create_targeted_array.each do |item|
        is_included = false if StatisticsHelper::SYMBOLS.include?(item) == false
      end
      is_included
    end
    expect(only_approved_symbols).to be(true)
  end
end

describe 'It should return a randomized targeted array' do
  it 'should return an array that is not empty' do
    expect(StatisticsHelper.randomized_targeted_array.empty?).to be(false)
  end
  it 'should return an array with 24 elements' do
    expect(StatisticsHelper.randomized_targeted_array.length).to be(24)
  end
end

describe 'Add empty hash to JSON file' do
  it 'should return a hash' do
    expect(StatisticsHelper.add_symbols_to_hash.empty?).to be(false)
  end
  it 'should return a hash with 27 keys' do
    expect(StatisticsHelper.add_symbols_to_hash.size).to be(27)
  end
  it 'should set the hash key values to an array with 5 elements' do
    expect(StatisticsHelper.add_symbols_to_hash['#'].length).to be(5)
  end
  it 'should set hash key elements to 0' do
    expect(StatisticsHelper.add_symbols_to_hash['#']).to eq([0, 0, 0, 0, 0])
    expect(StatisticsHelper.add_symbols_to_hash[':']).to eq([0, 0, 0, 0, 0])
  end
end
