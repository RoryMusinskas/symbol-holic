require_relative 'menu'
require_relative 'typing_statistics'
require 'terminal-table'

# create an instance to display the menu
@symbolic = Menu.new

# Method to hold the logic for the command line arguments
def command_line_arguments
  # If there is none or 1 arguments, run the following error checking on the arguments
  if ARGV.size == 0 || ARGV.size == 1
    # If there is no argument passed, display the menu
    if ARGV[0].nil?
      @symbolic.display_menu
    # If they pass -h, -H or --help, call the help_menu method
    elsif ARGV[0] == '-h' || ARGV[0] == '-H' || ARGV[0] == '--help'
      help_menu
      exit
    # If they pass -d, -D or --display, display their statistics to the terminal
    elsif ARGV[0] == '-d' || ARGV[0] == '-D' || ARGV[0] == '--display'
      @symbolic.display_statistics
      exit
    # If they pass -r, -R or --run, start the typing game without going to the menu
    elsif ARGV[0] == '-r' || ARGV[0] == '-R' || ARGV == '--run'
      puts 'Welcome to Symbol-holic'
      @symbolic.run_game
    # If they pass an invalid flag, puts an error and exit program
    else
      puts "That is an invalid argument. Type '-h', '-H', or '--help' to see a list of valid commands."
      exit
    end
  # If they enter more than one argument, puts an error and make them start program again.
  else
    puts "Please only input one argument at a time. Type '-h', '-H', or '--help' to see a list of valid commands."
  end
end

# The help menu method for the command line argument
def help_menu
  # create a terminal table to output the helper command line argument
  rows = []
  rows << ['Help', '-h, -H, --help', 'Displays this help page to explain the arguments passed to the command line']
  rows << :separator
  rows << ['Display', '-d, -D, --display', 'Display your typing scores, without entering the program']
  rows << :separator
  rows << ['Run', '-r, -R, --run', 'Start the typing game without entering the program']

  table = Terminal::Table.new title: 'Help Menu', headings: %w[Argument Flags Description], rows: rows
  puts table
end
command_line_arguments
