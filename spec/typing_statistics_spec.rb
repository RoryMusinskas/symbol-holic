require_relative '../lib/typing_statistics'

describe 'TypingStatistics' do
  # Testing the total count method
  it 'should add up the total count' do
    data = TypingStatistics.new
    expect(data.total_count(25, 25)).to eq(50)
  end
  # Testing the average accuracy method
  it 'should return the average accuracy of each key' do
    data = TypingStatistics.new
    expect(data.average_accuracy(1, 0)).to eq(100.0)
    expect(data.average_accuracy(1, 1)).to eq(50.0)
    expect(data.average_accuracy(1, 2)).to eq(33.3)
  end
  # Testing the average WPM method
  it 'should return the average WPM of each key' do
    data = TypingStatistics.new
    expect(data.average_wpm(140, 2)).to eq(70)
    expect(data.average_wpm(400, 10)).to eq(40)
  end
  # Testing the sort method
  it 'should return the averaged statistics sorted by speed and accuracy' do
    data = TypingStatistics.new
    averaged_statistics = { '#': [1, 1, 50, 60, 60], '&': [1, 0, 100, 70, 70] }
    expect(data.sort_averaged_statistics(averaged_statistics)).to eq({ '&': [1, 0, 100, 70, 70], '#': [1, 1, 50, 60, 60] })
  end
end
