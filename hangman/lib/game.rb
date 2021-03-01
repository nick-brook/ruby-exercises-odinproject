# frozen_string_literal: true

require_relative 'display'
require_relative 'common_modules'
require_relative 'load_file'

# game logic
class Game
  include Display
  include LoadGame
  include Common

  # get mode for game & instantiate objects
  def initialize
    @solution_obj = Solution.new
    @solution_arr = []
  end

  # load game or start new, iinitiate game
  def new_or_load
    user_input(INPUT_MSGS['load_or_new']) == GAME_NEW ? initiate_game : load_game
    game_turns
  end

  # load saved file and set variables
  def load_game
    file_name = file_to_load
    if file_name
      load_hash = json_load(file_name)
      @turn_obj = Turn.new
      @turn_obj.load_var(load_hash)
      @turn_obj.display_turn_results
    else
      new_or_load
    end
  end

  # set solution and display instructions and empty array
  def initiate_game
    @solution_arr = @solution_obj.solution_arr
    @turn_obj = Turn.new
    disp_msg(INFO_MSGS['game_instructions'])
    disp_resolved(@turn_obj.create_resolved_arr(@solution_arr))
  end

  # initiate game turns until game is over
  def game_turns
    @turn_obj.play_turn(@solution_arr) until @turn_obj.game_over(@solution_arr)
  end

  def play_again
    user_input(INPUT_MSGS['play_again']) == PLAY_AGAIN
  end
end
