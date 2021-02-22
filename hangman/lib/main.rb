# frozen_string_literal: true

require_relative 'game'
require_relative 'display'
require_relative 'solution'
require_relative 'humansolution'
require_relative 'computer_solution'
require_relative 'turn'

# creates game object and starts game
def hangman
  game = Game.new
  game.play_game
  hangman if game.play_again
end

hangman
