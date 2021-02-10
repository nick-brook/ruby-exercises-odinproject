# frozen_string_literal: true

require_relative 'display'

# logic for computer to crack code
class ComputerSolver
  include Display
  def initialize
    @turn = 1
    @res_wrk_arr = []
    @guess_arr = []
  end

  # controls computer turn and returns guess
  def comp_turn(solution, turn_obj)
    ## guess correct nums
    @guess_arr = correct_nums(solution, turn_obj) if @guess_arr.length <= 4
    ## set correct positions
    # @pos_score = turn_obj.correct_position(@guess_arr, solution)
    @turn += 1
    p "guess array #{@guess_arr}"
    @guess_arr
  end

  # guess correct number return results array
  def correct_nums(solution, turn_obj)
    # puts "turn number #{@turn} previous results #{@res_wrk_arr}"
    # get number of correct guesses last time
    num_correct = turn_obj.number_correct(@guess_arr, solution).length
    # delete wrong guesses
    (4 - num_correct).times do
      @res_wrk_arr.pop
    end
    # fill array with new guesses (number is this turn)
    (4 - @res_wrk_arr.length).times do
      @res_wrk_arr.push(@turn.to_s)
    end
    @res_wrk_arr
  end

  def correct_position
    p 'position'
  end
end
