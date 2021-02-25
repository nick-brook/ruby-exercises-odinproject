# frozen_string_literal: true
require_relative 'display'
require_relative 'common_modules'
require_relative 'load_file'

# game logic
class Game
  include Display, Load_Game, Common

  # attr_reader :solution_arr, :resolved_arr
# get mode for game & instantiate objects
  def initialize
    @solution_obj = Solution.new
    @solution_arr = []
  end

  # load game or new
  def new_or_load
    if user_input(MSGS['load_or_new'], ERR_MSGS['load_or_new'], RGX['load_or_new']) == GAME_NEW
      play_game
    else
      load_game
    end
    game_turns
  end

  def load_game
    # load saved game into hash
    load_hash = json_load(file_to_load)
    # recover solution
    @solution_arr = load_hash['solution_arr']
    # instantiate turn object
    @turn_obj = Turn.new(@solution_arr)
    # set turn variables from saved gam
    @turn_obj.set_load_var(load_hash)
    # display current state
    @turn_obj.display_turn_results
  end

  def play_game
    # get game solution from file
    @solution_arr = @solution_obj.solution_arr
    @turn_obj = Turn.new(@solution_arr)
    disp_msg(MSGS['game_instructions'])
    # create and display resolved array
    disp_resolved(@turn_obj.create_resolved_arr(@solution_arr))
  end

  # initiate game turns
  def game_turns
      @turn_obj.play_turn(@solution_arr) until @turn_obj.game_over(@solution_arr)
  end

  def play_again
    user_input(MSGS['play_again'], ERR_MSGS['play_again'], RGX['play_again']) == PLAY_AGAIN
  end

  def save_option
    @turn_obj.user_input(MODE_SAVE)
  end
end
