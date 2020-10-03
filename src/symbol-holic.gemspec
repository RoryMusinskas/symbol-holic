Gem::Specification.new do |s|
  s.name = 'symbol-holic'
  s.version = '0.0.4'
  s.date = '2020-10-01'
  s.summary = 'Symbol-holic'
  s.description = 'A simple symbol typing game'
  s.authors = 'Rory Musinskas'
  s.files = Dir[
    'lib/menu.rb',
    'lib/statistics_helper.rb',
    'lib/typing_game.rb',
    'lib/typing_statistics.rb',
    'public/key_scores.json'
  ]
  s.require_paths = %w[lib public]
  s.add_runtime_dependency 'byebug', '~> 11.1.3'
  s.add_runtime_dependency 'colorize', '~> 0.8.1'
  s.add_runtime_dependency 'json', '~> 2.3', '>= 2.3.1'
  s.add_runtime_dependency 'terminal-table', '~> 1.8'
  s.add_runtime_dependency 'tty-pie', '~> 0.4.0'
  s.add_runtime_dependency 'tty-prompt', '~> 0.22.0'
  s.executables << 'symbol_holic'
  s.required_ruby_version = '>= 2.4'
end
