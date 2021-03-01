# frozen_string_literal: true

# game messages, display methods and constants
module Display
  FILE_NAME = '5desk.txt'
  GAME_LENGTH = 7
  PLAY_AGAIN = 'Y'
  OVERRIGHT = 'Y'
  GAME_SAVE = '1'
  GAME_LOAD = '2'
  GAME_NEW = '1'
  SAVE_DIR = 'output'

  INPUT_MSGS = {
    'load_or_new' => ["\nEnter 1 for new game or 2 to load game.",
                      /^[12]{1}$/,
                      'Invalid entry - Please enter 1 for new game or 2 to load game.'],
    'play_again' => ["\nWould you like to play again? enter y or n !",
                     /^[YN]{1}$/,
                     'Invalid entry - Please enter y or n.'],
    'to_play' => ["\nEnter a letter or 1 to save game.",
                  /^[A-Z1]{1}$/,
                  'Invalid entry - Please enter a letter to play or 1 to save.'],
    'file_name' => ["\nPlease enter a file name...",
                    %r{^[^|/]*$},
                    'Invalid entry - / and | not allowed in file name.'],
    'file_exists' => ["\nFile already exists. over right ? Y/N",
                      /^[YN]{1}$/,
                      'Invalid entry - over right file enter Y or N.']
  }.freeze

  INFO_MSGS = {
    'file_saved' => 'Game saved. Please continue...',
    'file_not_saved' => 'Game not saved.',
    'game_instructions' => "Welcome to Hangman !\nTo play enter any letter to guess the word..
                            \nYou have #{GAME_LENGTH} lives to win...",
    'game_won' => 'Congratulations you won!',
    'no_files' => 'There are no saved files.'
  }.freeze

  ERR_MSGS = {
    'invalid_file_num' => 'Please choose a valid number for a file.',
    'duplicate_letter' => "\nYou already guessed this letter, try again!"
  }.freeze

  def disp_msg(message)
    puts "\n#{message}"
  end

  def disp_file_arr(file_arr)
    puts "\nChoose the number of the file you want to load"
    file_arr.each_with_index do |file, index|
      puts "#{index + 1}: #{file.delete_suffix('.txt')}"
    end
  end

  def disp_wrong_letters(wrong_arr)
    puts "\nWrong letters: #{wrong_arr.join(', ')}"
  end

  def disp_resolved(resolved_arr)
    puts "\n"
    resolved_arr.each do |item|
      if item == '_'
        print '__ '
      else
        print item, ' '
      end
    end
    puts "\n"
  end

  def disp_turns(turn)
    puts "\n#{turn} lives lost, you have #{GAME_LENGTH - turn} lives left."
  end

  def disp_game_lost(solution_arr)
    puts "\nNo lives left... you lost!!"
    puts "\nThe answer was #{solution_arr.join}"
  end
end
