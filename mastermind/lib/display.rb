# frozen_string_literal: true

require 'colorize'

# player class creates object that contains player
module Display
  COMP = 2
  HUMAN = 1
  FIRST_GUESS = %w[1 1 2 2].freeze
  CORRECT_NUMBER = 'Y'
  CORRECT_PLACE = 'X'
  GAME_LENGTH = 12
  PLAY_AGAIN = 'Y'

  # create color codes
  def disp_num_color(num)
    @colors = { '1' => "\e[0;30;41m  1  \e[0m",
                '2' => "\e[0;30;43m  2  \e[0m",
                '3' => "\e[0;30;46m  3  \e[0m",
                '4' => "\e[0;30;44m  4  \e[0m",
                '5' => "\e[0;30;103m  5  \e[0m",
                '6' => "\e[0;30;47m  6  \e[0m" }[num]
  end

  def disp_clue_color(clue)
    {
      'X' => "\e[91m\u25CF\e[0m ",
      'Y' => "\e[37m\u25CB\e[0m "
    }[clue]
  end

  def disp_game_instructions
    puts 'Instructions'
    puts "\nTo play enter 4 numbers to choose colours .."
    (1..6).each do |i|
      print disp_num_color(i.to_s)
    end
    print "\n\n Right colour wrong place : ", disp_clue_color('Y')
    print "\n Right colour right place : ", disp_clue_color('X')
    puts "\n\nYou have 10 goes to get the code..."
  end

  def disp_to_play
    puts "\nMake your 4 choices!"
    puts "\n"
  end

  def disp_invalid_entry
    puts 'Please enter 4 digits (1 to 6)'
    false
  end

  def disp_game_won
    puts 'Congratulations you won!'
  end

  def disp_game_lost
    puts 'Your shit - Arrrgh!!'
  end

  def disp_play_again
    puts 'Would you like to play again? enter y or n !'
  end

  def disp_play_mode
    puts 'To guess the computer generated code -- ENTER "C" '
    puts 'or for the computer to guess your code ENTER "G"'
  end

  def disp_enter_code
    puts 'Enter your 4 digit code for the computer to guess'
  end

  def turn_display(turn_arr, results)
    turn_arr.each do |item|
      print disp_num_color(item.to_s)
    end
    print '  clues.. '
    results.each do |item|
      print disp_clue_color(item.to_s)
    end
    puts "\n"
  end
end
