# frozen_string_literal: true

# player class creates object that contains player
class Player
  def initialize
    @player = 'X'
  end

  def next
    @player
  end

  def change_player(player)
    @player = player == 'X' ? 'O' : 'X'
  end
end
