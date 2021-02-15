# frozen_string_literal: true

require_relative 'display'

# game logic
class Game
  include Display
  @solution = []

  attr_reader :mode, :turn_obj, :solution
# get mode for game & instantiate objects
  def initialize
    @mode = game_set_mode
    @turn_obj = Turn.new
    @solution_obj = Solution.new
    @human_solution_obj = HumanSolution.new
    @computer_solve_obj = ComputerSolver.new
  end

  def play_game
    # get game solution
    @solution = game_set_up
    # initiate game turns
    game_turns
  end

  def game_set_mode
    disp_play_mode
    gets.chop.upcase == 'G' ? COMP : HUMAN
  end

  # method to set/get solution and return it
  def game_set_up
    if mode == HUMAN
      disp_game_instructions
      # get computer generated solution
      @solution_obj.solution
    else
      # get solution player enters if valid
      @human_solution_obj.human_solution(@turn_obj)
    end
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
