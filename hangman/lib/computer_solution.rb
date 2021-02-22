# frozen_string_literal: true

require_relative 'display'

# logic for computer to crack code
class ComputerSolver
  include Display
  def initialize
    @res_wrk_arr = []
  end

  # controls computer turn and returns guess
  def comp_turn(solution, turn_obj)
    # first turn use FIRST_GUESS
    if turn_obj.turn.zero?
      @res_wrk_arr = create_combinations
      guess_arr = FIRST_GUESS
    else
      # filter the array of combos, passing results from last turn
      @res_wrk_arr = filter_combos(turn_obj.results, solution, turn_obj)
      # next guess is first in list
      guess_arr = @res_wrk_arr[0]
    end
    guess_arr
  end

  def filter_combos(results, solution, turn_obj)
    @res_wrk_arr.filter do |item|
      # check if score for each element = results of last guess
      results != turn_obj.calculate_results(item, solution)
    end
  end

  def create_combinations
    combo_wrk_arr = []
    NUMBER_RANGE.each do |a|
      NUMBER_RANGE.each do |b|
        NUMBER_RANGE.each do |c|
          NUMBER_RANGE.each do |d|
            combo_wrk_arr.push([a, b, c, d])
          end
        end
      end
    end
    combo_wrk_arr
  end
end
