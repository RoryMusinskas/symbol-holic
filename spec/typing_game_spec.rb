require_relative '../lib/typing_game'

describe 'calculate words per minute' do
  it 'should return words per minute from the users times' do
    game = TypingGame.new
    expect(game.words_per_min(60.0, 120.0)).to eq(1)
  end
end

describe 'calculate statistics' do
  it 'should add array with the count, errors and WPM to empty hash key' do
    game = TypingGame.new
    # Pass in the WPM so you don't have to run the game
    expect(game.calculate_statistics('#', 1, 60)).to eq([1, 1, 60])
  end

  it 'should add and total the the count, errors and WPM ' do
    game = TypingGame.new
    game.calculate_statistics('#', 1, 60)

    expect(game.calculate_statistics('#', 2, 80)).to eq([2, 3, 140])
  end
end
