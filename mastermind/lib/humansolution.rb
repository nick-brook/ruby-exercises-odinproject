# frozen_string_literal: true

require_relative 'display'
# require_relative 'turn'

class HumanSolution
  include Display
    
  def initialize
    @human_code = ""
  end

  def get_human_code
    disp_enter_code
    @human_code = gets.chop
  end

  def human_solution(turn_obj)
    check = false

    while  check == false do
      check = turn_obj.valid_turn(self.get_human_code)
    end
    self.human_code.split("")
  end

  def human_code
    @human_code
  end

end
