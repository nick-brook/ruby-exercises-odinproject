# frozen_string_literal: true

require_relative 'game'
require_relative 'display'
require_relative 'solution'
require_relative 'humansolution'
require_relative 'computer_solution'
require_relative 'turn'

# creates game object and starts game
def mastermind
  game = Game.new
  game.play_game
  mastermind if game.play_again
end

mastermind
