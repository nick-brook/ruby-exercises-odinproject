# frozen_string_literal: true

require_relative 'display'

# creates random solution
class Solution
  include Display

  attr_reader :solution_arr

  def initialize
    @solution_arr = create_random_solution
  end

  def create_random_solution
    solution_arr = []
    #  open file and put contents in array
    contents = File.open(FILE_NAME, 'r')

    # filter for words between 5 and 12 chars long
    while !contents.eof?
      line = contents.readline.chomp
      solution_arr.push(line) if line.length > 4 && line.length < 13
    end

    # choose random word and create arrray of letters
    word = solution_arr.sample.upcase
    word.split(//)
  end
end
