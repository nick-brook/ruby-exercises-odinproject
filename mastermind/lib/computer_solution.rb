# frozen_string_literal: true

require_relative 'display'

# logic for computer to crack code
class ComputerSolver
  include Display
  def initialize
    # @res_wrk_arr = []
    @guess_arr = FIRST_GUESS
    @results = []
    @combo = create_combinations
  end

  # controls computer turn and returns guess
  def comp_turn(solution, turn_obj)

    # first turn use FIRST_GUESS
    p solution

      # get score of guess
      @results = turn_obj.calculate_results(@guess_arr, solution)
      # filter the array of combos
      wrk_arr = filter_combos(@results, solution, turn_obj)
      
      # new guess is first in list
      @guess = wrk_arr[0]
   
      if turn_obj.turn == 1
        @guess_arr = FIRST_GUESS
      end
      # p "computer guess #{@guess_arr} turn #{turn_obj.turn}"
      @guess_arr

    ## guess correct nums
    # @guess_arr = correct_nums(solution, turn_obj) if @guess_arr.length <= 4
    ## set correct positions
    # @pos_score = turn_obj.correct_position(@guess_arr, solution)
    # @turn += 1
    # p "guess array #{@guess_arr}"
    # @guess_arr
  end

  def filter_combos(results, solution, turn_obj)
p @combo.length

    wrk_arr = @combo.filter do |item|
        # check if score for each element = results of last guess
        guess_results = turn_obj.calculate_results(item, solution)
        # p "results from last guess are #{results} results for element #{item} are #{guess_results}"
        results == guess_results ? true : false
    end

    p wrk_arr.length
    wrk_arr

  end


  def create_combinations
    combo_wrk_arr = []
    for a in 1..6
      for b in 1..6
        for c in 1..6
          for d in 1..6
            elem = [a.to_s,b.to_s,c.to_s,d.to_s]
            combo_wrk_arr.push(elem)
          end
        end
      end
    end
    combo_wrk_arr
  end

  # # guess correct number return results array
  # def correct_nums(solution, turn_obj)
  #   # puts "turn number #{@turn} previous results #{@res_wrk_arr}"
  #   # get number of correct guesses last time
  #   num_correct = turn_obj.number_correct(@guess_arr, solution).length
  #   # delete wrong guesses
  #   (4 - num_correct).times do
  #     @res_wrk_arr.pop
  #   end
  #   # fill array with new guesses (number is this turn)
  #   (4 - @res_wrk_arr.length).times do
  #     @res_wrk_arr.push(@turn.to_s)
  #   end
  #   @res_wrk_arr
  # end

  # def correct_position
  #   p 'position'
  # end
end
