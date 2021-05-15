# frozen_string_literal: true
require_relative 'display'
require_relative 'constants'

class Board
  # include Display 
  include Constants
  attr_reader :board_arr

  # create empty board array
  def initialize
    @board_arr = EMPTY_BOARD
  end

  def update_board(column, player)
    @board_arr[column - 1].push(player)
  end

end
