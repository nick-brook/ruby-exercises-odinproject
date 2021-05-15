# frozen_string_literal: true

# game messages, display methods and constants
module Display

    INPUT_MSGS = {
      'load_or_new' => ["\nEnter 1 for new game or 2 to load game.",
                        /^[12]{1}$/,
                        'Invalid entry - Please enter 1 for new game or 2 to load game.']
    }.freeze

    INFO_MSGS = {
      'column_full' => "That column is full please choose another.",
      'invalid_column' => "Invalid Entry - Columns are 1 to 7.",

      'game_won' => 'Congratulations you won!',
      'no_files' => 'There are no saved files.'
    }.freeze

    ERR_MSGS = {
      'invalid_file_num' => 'Please choose a valid number for a file.',
      'duplicate_letter' => "\nYou already guessed this letter, try again!"
    }.freeze

  def disp_msg(message)
    # puts "\n#{message}"
    puts "\n#{INFO_MSGS[message]}"
  end

  def disp_game_lost
  end
  
end
