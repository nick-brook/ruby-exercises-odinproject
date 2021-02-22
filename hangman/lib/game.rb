# frozen_string_literal: true

require_relative 'display'

# game logic
class Game
  include Display
  @solution = []

  attr_reader :mode, :turn_obj, :solution
# get mode for game & instantiate objects
  def initialize
    @turn_obj = Turn.new
    @solution_obj = Solution.new
  end

  def play_game
    # get game solution
    @solution = @solution_obj.solution
    # initiate game turns
    game_turns
  end


  # initiate turns until game over
  def game_turns
    @turn_obj.play_turn(solution, mode, @computer_solve_obj) until @turn_obj.game_over(@turn_obj.results,mode)
  end

  def play_again
    disp_play_again
    gets.chop.upcase == PLAY_AGAIN
  end
end
