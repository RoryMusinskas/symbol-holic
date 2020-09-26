require 'tty-prompt'
require 'json'
require_relative 'typing_game'
require_relative 'typing_statistics'

class Menu
  def menu_selection
    # Choices for the user to select at the menu
    menu_choices = [
      { name: 'Start Typing', value: '1' },
      { name: 'Display your typing statistics', value: '2' },
      { name: 'Exit', value: '3' }
    ]
    # TTY prompt with the menu choices, users can select one of these items
    TTY::Prompt.new.select('Welcome to Symbol-holic!', menu_choices)
  end

  def display_menu
    loop do
      choice = menu_selection.to_i
      # Start typing game if user selects 'Start Typing'
      if choice == 1
        @typing_game = TypingGame.new
        @scores = @typing_game.run_game
        @typing_statistics = TypingStatistics.new
        @typing_statistics.statistics(@scores)
      # TypingStatistics.statistics(@scores)
      # Display the users statistics if they select 'Display your typing statistics'
      elsif choice == 2
        # If the user hasn't played a game yet, there is no need to display their typing scores
        # It throws an error as the Class is nil at that stage
        begin
          # If it is not nil, display their statistics
          @typing_statistics.display_statistics
          # If it is nil, display a prompt and let them choose another menu item
        rescue StandardError
          puts
          puts "You haven't played a game yet."
          puts
        end
        # Exit the program if the user selects 'Exit'
      elsif choice == 3
        exit
      end
    end
  end
end
