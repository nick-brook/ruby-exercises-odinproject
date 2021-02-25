# frozen_string_literal: true

require_relative 'game'
require_relative 'display'
require_relative 'solution'
require_relative 'turn'
require_relative 'save_file'
require_relative 'load_file'
require_relative 'common_modules'

# creates game object and starts game
def hangman
  game = Game.new
  game.new_or_load
  hangman if game.play_again
end

hangman
