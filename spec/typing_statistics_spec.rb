require_relative '../lib/typing_statistics'

describe 'statistics' do
  it 'should add first game to sorted hash' do
    scores = { '#' => [1, 1, 50, 50, 50] }
    data = TypingStatistics.new
    average = data.statistics(scores)
    expect(average['#']).to eq([1, 1, 50, 50, 50])
  end
  it 'should add and average multiple games and add to sorted hash' do
    # fake score to add in for last game
    scores = { '#' => [1, 1, 50, 50, 50] }
    # new instance
    data = TypingStatistics.new
    # wipe file clean to see if it errors and so this test will work
    data.wipe_file
    # run scores for first game
    data.statistics(scores)
    # run scores for second game and get average
    average = data.statistics(scores)
    expect(average['#']).to eq([2, 2, 50, 100, 50])
  end
end

describe 'total count' do
  # Testing the total count method
  it 'should add up the total count' do
    data = TypingStatistics.new
    expect(data.total_count(25, 25)).to eq(50)
  end
end
describe 'average accuracy' do
  # Testing the average accuracy method
  it 'should return the average accuracy of each symbol' do
    data = TypingStatistics.new
    expect(data.average_accuracy(1, 0)).to eq(100.0)
    expect(data.average_accuracy(1, 1)).to eq(50.0)
    expect(data.average_accuracy(1, 2)).to eq(33.3)
  end
end
describe 'words per min' do
  # Testing the average WPM method
  it 'should return the average WPM of each symbol' do
    data = TypingStatistics.new
    expect(data.average_wpm(140, 2)).to eq(70)
    expect(data.average_wpm(400, 10)).to eq(40)
  end
end
describe 'sort average data' do
  # Testing the sort method
  it 'should return the averaged statistics sorted by speed and accuracy' do
    data = TypingStatistics.new
    averaged_statistics = { '#': [1, 1, 50, 60, 60], '&': [1, 0, 100, 70, 70] }
    expect(data.sort_averaged_statistics(averaged_statistics)).to eq({ '&': [1, 0, 100, 70, 70], '#': [1, 1, 50, 60, 60] })
  end
end
describe 'file path' do
  it 'should get the absolute file path of the user' do
    data = TypingStatistics.new
    expect(data.file_path).to eq('/home/muzz00ka/Desktop/symbolic/public/key_scores.json')
  end
end
