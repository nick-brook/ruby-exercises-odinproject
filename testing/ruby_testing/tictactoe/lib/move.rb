# frozen_string_literal: true

require_relative 'display'
# move class gets user moves and validates
class Move
  include Display

  def initialize
    @first_move = true
  end

  # checks if valid move:- between 1 and 10, not duplicate
  def valid_move(move, board_entry)
    # if out of range return false
    return false unless in_range?(move)
    return empty_square?(board_entry)
  end

  # check move is in range (1-9)
  def in_range?(move)
    if move >= 1 && move <= 9 
      true 
    else
      disp_invalid_move
      false
    end
  end

  # check move is not already played (value in board hash must be ' ')
  def empty_square?(board_entry)
    board_entry == ' ' ? true : false
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
