# frozen_string_literal: true

require_relative 'display'

# creates random solution
class Solution
  include Display

  def initialize
    @solution_arr = create_random_solution
  end

  def create_random_solution
    solution_arr = []
    (1..4).each do |_i|
      solution_arr.push(rand(1..6).to_s)
    end
    solution_arr
  end

  def solution
    @solution_arr
  end
end
