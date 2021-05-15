# frozen_string_literal: true

require_relative 'display'


# move class gets user moves and validates
class Turn
  # include Common
  include Display
  attr_reader :player

  def initialize
    @player = 1
  end


  # plays and displays results for each turn, handles invalid entry
  def new_turn(board_arr)
    loop do
      user_input = gets.chomp
      verified_input= valid_input(user_input.to_i) if valid_entry?(user_input)
      return verified_input if verified_input
    end
  end

  # checks that column is not full
  def column_full?(column, board_arr)
    if board_arr[column -1].length == 6
      disp_msg('column_full')
      true 
    else
      false
    end
  end

    # checks that entry is valid (between 1 and 7 )
    def valid_entry?(user_input)
      if user_input.match?(/^[1-7]{1}$/)
        true 
      else
        disp_msg('invalid_column')
        false
      end
    end

end
