# frozen_string_literal: true

require_relative 'display'

# move class gets user moves and validates
class Turn
  include Display
  attr_reader :turn, :results

  def initialize
    @turn_arr = []
    @turn = 0
    @results = []
  end

  def play_turn(solution, mode, comp_obj)
    # if valid input
    if mode == HUMAN
      # check for valid turn
      turn_arr = user_turn_input
      return false unless turn_arr
    else
      # get computer guess
      turn_arr = comp_obj.comp_turn(solution, self)
    end

    # calculate and display results
    calc_and_display(turn_arr, solution)
    @turn += 1
    true
  end

  # def turn
  #   @turn
  # end

  # calculates and displays results of turn
  def calc_and_display(turn_arr, solution)
    # calculate results
    @results = calculate_results(turn_arr, solution)
    # display results
    turn_display(turn_arr, results)
  end

  # def results
  #   @results
  # end

  def game_over(results)
    # p "turn is #{@turn}"
    if results.length == 8
      disp_game_won
      true
    elsif turn == GAME_LENGTH
      disp_game_lost
      true
    else
      false
    end
  end

  def calculate_results(turn, sol)
    results = number_correct(turn, sol)
    results + correct_position(turn, sol)
  end

  def correct_position(turn, sol)
    results_arr = []
    wrk_arr = turn.slice(0, sol.length)
    wrk_arr.each_with_index do |item, index|
      results_arr.push(CORRECT_PLACE) if item == sol[index]
    end
    results_arr
  end

  # checks number of correct gueses and returns array of correct guess
  def number_correct(turn, sol)
    results_arr = []
    wrk_arr = turn.slice(0, sol.length)
    # calculate number of correct numbers
    sol.each do |item|
      # check if item is turn
      next unless wrk_arr.include?(item.to_s)

      # increment counter
      results_arr.push(CORRECT_NUMBER)
      # delete element so don't double count
      index = wrk_arr.index(item)
      wrk_arr.delete_at(index)
    end
    results_arr
  end

  #  checks if user has entered a valid 4 digit code, returns true or false
  def valid_turn(num)
    regex = /[1-6]{4}/
    # p "valid turn #{num}"
    if num.match(regex) && num.length == 4
      true
    else
      disp_invalid_entry
      false
    end
  end

  # get user input returns user guess as an array
  def user_turn_input
    # get user input
    disp_to_play if turn.zero
    num = gets.chop
    @turn_arr = num.split('') if valid_turn(num)
  end
end
