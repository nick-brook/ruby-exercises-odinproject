# frozen_string_literal: true

require_relative 'display'
# require_relative 'turn'

# Class for handle user input of solution
class HumanSolution
  attr_reader :human_code

  include Display
  def initialize
    @human_code = ''
  end

  def enter_human_code
    disp_enter_code
    @human_code = gets.chop
  end

  def human_solution(turn_obj)
    check = false
    check = turn_obj.valid_turn(enter_human_code) while check == false
    human_code.split('')
  end
end
