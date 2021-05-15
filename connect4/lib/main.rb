# frozen_string_literal: true

require_relative 'game'
require_relative 'display'
require_relative 'solution'
require_relative 'turn'
require_relative 'board'
require_relative 'common_modules'

# creates game object and starts game
def connect4
  game = Game.new
  game.new_or_load
  hangman if game.play_again
end

connect4
