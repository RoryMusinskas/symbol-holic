require 'tty-prompt'
require 'json'
require 'colorize'
require_relative 'typing_game'
require_relative 'typing_statistics'

class Menu
  def initialize
    @typing_statistics = TypingStatistics.new
  end

  def menu_selection
    # Choices for the user to select at the menu
    menu_choices = [
      { name: 'Start Typing', value: '1' },
      { name: 'Display your typing statistics', value: '2' },
      { name: 'Reset your typing statistics', value: '3' },
      { name: 'Exit', value: '4' }
    ]
    # TTY prompt with the menu choices, users can select one of these items
    TTY::Prompt.new.select('Welcome to Symbol-holic!', menu_choices)
  end

  # This is the loop which runs and displays the menu to the user
  def display_menu
    loop do
      choice = menu_selection.to_i
      # Start typing game if user selects 'Start Typing'
      if choice == 1
        run_game
      # Display the users statistics if they select 'Display your typing statistics'
      elsif choice == 2
        display_statistics
      # Reset users statistics if they want to
      elsif choice == 3
        reset_statistics
        # Exit the program if the user selects 'Exit'
      elsif choice == 4
        exit
      end
    end
  end

  # Added in for the command line arguments. We can call display_statistics on menu and not create a new TypingStatistics instance
  def display_statistics
    # If the user hasn't played a game yet, there is no need to display their typing scores
    # It throws a JSON::ParsorError as the file is empty and cannot be parsed
    @typing_statistics.display_statistics
    # If it is not empty, display their statistics
    # If it is empty, display a prompt and let them choose another menu item
  rescue JSON::ParserError
    puts
    puts "You haven't played a game yet. Please play one game and then try again.".colorize(:red)
    puts
  end

  # Method for running the game
  def run_game
    @typing_game = TypingGame.new
    @scores = @typing_game.run_game
    @typing_statistics.statistics(@scores)
  end

  # Menu option and TTY prompt for deleting all typing statistics
  def reset_statistics
    reset_choices = [
      { name: 'Yes', value: '1' },
      { name: 'No', value: '2' }
    ]
    choice = TTY::Prompt.new.select('Are you sure?', reset_choices).to_i
    if choice == 1
      @typing_statistics.wipe_file
    elsif choice == 2
      display_menu
    end
  end
end
