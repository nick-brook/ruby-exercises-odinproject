# frozen_string_literal: true

require_relative 'display'
require_relative 'common_modules'

# game logic
class Game
  include Display
  include Common

  # get mode for game & instantiate objects
  def initialize
  end


  # set solution and display instructions and empty array
  def initiate_game
  end

  # initiate game turns until game is over
  def game_turns
  end

  def play_again
    user_input(INPUT_MSGS['play_again']) == PLAY_AGAIN
  end
end
