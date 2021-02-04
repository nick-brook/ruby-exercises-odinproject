# frozen_string_literal: true

require_relative 'display'
# move class gets user moves and validates
class Move
  include Display

  def initialize
    @first_move = true
  end

  def valid_move(move, board_entry)
    p board_entry
    if board_entry.nil? || move <= 1 && move >= 9
      # puts 'Invalid move. Enter 1 to 9'
      disp_invalid_move
      false
    elsif board_entry != ' '
      disp_duplicate_move
      false
    else
      true
    end
  end

  def move_instructions
    # instructions for first move
    disp_instructions if @first_move
    @first_move = false
  end

  def get_move(player)
    # get user position
    disp_to_play(player)
    move_instructions
    gets.chop.to_i
  end
end
