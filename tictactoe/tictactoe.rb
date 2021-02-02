# frozen_string_literal: true

# new game creates Move instance for each position with no score
class Board
  attr_accessor :board

  def initialize
    @board = {}
    i = 1

    while i < 10
      @board[i.to_i] = ' '
      i += 1
    end
  end

  def update_board(position,player)

    # check position not already played
    if @board[position] != " "
      puts "Move already made! Try again"
      false
    else
      @board[position] = player
    end

  end

  def display_board
    puts "#{@board[1]} | #{@board[2]} | #{@board[3]}"
    puts '- - - - -'
    puts "#{@board[4]} | #{@board[5]} | #{@board[6]}"
    puts '- - - - -'
    puts "#{@board[7]} | #{@board[8]} | #{@board[9]}"
  end

  def check_combo(combo)
    board_arr_x = []
    board_arr_o = []
    # check valid combo
    @board.each_pair do |key, value|
      board_arr_x.push(key) if value == 'X'
      board_arr_o.push(key) if value == 'O'
    end

    board_arr_x == combo || board_arr_o == combo ? true : false
  end

  def game_won
    winning_combos = [[1, 2, 3], [3, 5, 7], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

    # for each element check for relevant poisition if all X or O
    won = false
    winning_combos.each do |item|
      if check_combo(item)
        puts 'You Won!'
        won = true
      end
    end

    won
  end
end

class Player
  def initialize
    @player = "X"
  end

  def next
    @player
  end

  def change_player(player)
    player == "X" ? @player = "O" : @player = "X"
  end

end

class Move
  def initialize
  end

  def get_move(player)
     # get user position
    puts "#{player} to play"
    p "Enter Position 1 to 9"
    p "1 is top left - 9 is bottom right"
    gets.chop.to_i
  end

end

game = Board.new
player = Player.new
move = Move.new


winner = false
while winner == false

  position = move.get_move(player.next)

  # update game board with user choice
  if game.update_board(position,player.next)

    # display the board
   game.display_board
    # check if game is won
    winner = game.game_won

    player.change_player(player.next)
  end
end
