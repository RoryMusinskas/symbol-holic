require 'tty-prompt'
require_relative 'typing_game'
require_relative 'typing_statistics'

class Menu
  def initialize
    # If it is initialized up here then it doesn't generate a new array/object each time
    # @typing_game = TypingGame.new
    @times_played = 0
  end

  def menu_selection
    # Choices for the user to select at the menu
    menu_choices = [
      { name: 'Start Typing', value: '1' },
      { name: 'View your typing speeds', value: '2' },
      { name: 'Exit', value: '3' }
    ]
    # TTY prompt with the menu choices, users can select one of these items
    TTY::Prompt.new.select('Welcome to Symbol-holic!', menu_choices)
  end

  def display_menu
    loop do
      choice = menu_selection.to_i
      if choice == 1
        @times_played += 1
        @scores = TypingGame.new.run_game
        TypingStatistics.stats(@scores, @times_played)
      elsif choice == 2
        TypingStatistics.display_scores
      elsif choice == 3
        exit
      end
    end
  end
end
