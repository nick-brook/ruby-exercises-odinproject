# frozen_string_literal: true

require_relative 'display'
require 'json'

class Save_Game
  include Display

  def initialize(solution_arr, turn, wrong_arr, guess_arr, resolved_arr)
    @solution_arr = solution_arr
    @turn = turn
    @wrong_arr = wrong_arr
    @guess_arr = guess_arr
    @resolved_arr = resolved_arr
    self.save_file
  end

  def save_file

    # get file name
    text = to_json

    puts text
    # create directory
    Dir.mkdir(SAVE_DIR) unless Dir.exist?(SAVE_DIR)
    file_name = "#{SAVE_DIR}/#{get_file_name}.txt"
    File.open(file_name, 'w') do |file|
      file.puts text
    end

  end

  def get_file_name
    # get user input
    disp_file_name
    file_name = gets.chop
  end

  def to_json
    JSON.dump ({
      :solution_arr => @solution_arr,
      :turn => @turn,
      :guess_arr => @guess_arr,
      :wrong_arr => @wrong_arr,
      :resolved_arr => @resolved_arr
    })
  end


end