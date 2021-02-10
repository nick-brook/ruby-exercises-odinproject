# frozen_string_literal: true

require_relative 'display'
# new game creates Move instance for each position with no score
class Board
  include Display

  def initialize
    @board = {}
    i = 1

    while i < 10
      @board[i.to_i] = ' '
      i += 1
    end
  end

  def getter_board
    @board
  end

  def update_board(position, player)
    @board[position] = player
    display_board
  end

  def display_board
    puts "#{@board[1]} | #{@board[2]} | #{@board[3]}"
    puts '- - - - -'
    puts "#{@board[4]} | #{@board[5]} | #{@board[6]}"
    puts '- - - - -'
    puts "#{@board[7]} | #{@board[8]} | #{@board[9]}"
  end

  def check_board(combo, board_arr)
    if combo.all? do |item|
         board_arr.include?(item)
       end
      true
    else
      false
    end
  end

  def check_combo(combo)
    board_arr_x = []
    board_arr_o = []
    # build array of x and y poistion
    @board.each_pair do |key, value|
      board_arr_x.push(key) if value == 'X'
      board_arr_o.push(key) if value == 'O'
    end

    # check whether all entries in the winning combo are in the o or x board array

    check_board(combo, board_arr_x) || check_board(combo, board_arr_o) ? true : false
  end

  def game_draw
    if @board.all? do |_k, value|
         %w[X O].include?(value)
       end
      disp_draw
      true
    else
      false
    end
  end

  def game_won
    winning_combos = [[1, 2, 3], [3, 5, 7], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9]]

    # for each element check for relevant poisition if all X or O
    won = false
    winning_combos.each do |item|
      if check_combo(item)
        disp_won
        won = true
      end
    end

    won
  end
end
