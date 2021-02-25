# frozen_string_literal: true

# player class creates object that contains player
module Display
  FILE_NAME = '5desk.txt'
  GAME_LENGTH = 7
  PLAY_AGAIN = 'Y'
  MODE_PLAY = 'P'
  MODE_SAVE = 'S'
  GAME_SAVE = '1'
  GAME_LOAD = '2'
  GAME_NEW = '1'
  SAVE_DIR = 'output'

  MSGS = {
    'load_or_new' =>   "\nEnter 1 for new game or 2 to load game",
    'no_files' => "There are no saved files",
    'invalid_file_num' => "\nPlease choose a number for a file",
    'game_won' => "\nCongratulations you won!",
    'game_instructions' => "Welcome to Hangman !\nTo play enter any letter to guess the word..\nYou have #{GAME_LENGTH} lives to win...",
    'play_again' => "\nWould you like to play again? enter y or n !"
  }

  ERR_MSGS = {
    'load_or_new' => "Invalid entry - Please enter 1 or 2",
    'play_again' => "Invalid entry - Please enter y or n"
  }

  RGX = {
    'load_or_new' => /^[12]{1}$/,
    'play_again' => /^[YN]{1}$/
  }

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
    puts "\nWrong letters: #{wrong_arr.join(', ')}" if wrong_arr.length > 0
  end

  def disp_resolved(resolved_arr)
    puts "\n"
    resolved_arr.each do |item|
      if item == "_"
        print '__ '
      else
        print item, " "
      end
    end
    puts "\n"
  end

  def disp_game_lost(solution_arr)
    puts "\nNo more guesses... you lost!!"
    puts "\nThe answer was #{solution_arr.join}"
  end


  def disp_to_play
    puts "\nGuess a letter!"
    puts "\n"
  end

  def disp_to_save
    puts "\nTo save game enter 1 or a letter to continue"
    puts "\n"
  end

  def disp_invalid_char
    puts 'Please enter a character'
  end

  def disp_invalid_save_char
    puts 'Please enter 1 to save or a letter to continue'
  end



  def disp_play_again
    puts "\nWould you like to play again? enter y or n !"
  end

  def disp_turns(turn)
    puts "\nYou've lost #{turn} lives, #{GAME_LENGTH - turn} left."
  end

  def disp_duplicate
    puts "\nYou already guessed this letter, try again!"
  end

  def disp_file_name
    puts "\nPlease enter a file name..."
  end

end


