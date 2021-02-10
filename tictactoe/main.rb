# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'move'
require_relative 'display'

def tictactoe
  game = Board.new
  player = Player.new
  move = Move.new

  winner = false
  while winner == false

    # get player move
    new_move = move.get_move(player.next)

    # check valid move
    next unless move.valid_move(new_move, game.getter_board[new_move])

    # update board and display
    game.update_board(new_move, player.next)

    # check for draw
    break if game.game_draw

    # check if game is won
    winner = game.game_won

    # next player
    player.change_player(player.next)
  end
end

tictactoe
