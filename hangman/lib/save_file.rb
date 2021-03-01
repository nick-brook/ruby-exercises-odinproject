# frozen_string_literal: true

require_relative 'display'
require 'json'

# class handling saving of game file
class SaveGame
  include Common
  include Display

  def initialize(solution_arr, turn, wrong_arr, guess_arr, resolved_arr)
    @solution_arr = solution_arr
    @turn = turn
    @wrong_arr = wrong_arr
    @guess_arr = guess_arr
    @resolved_arr = resolved_arr
    save_file
  end

  # serialize text, create directory and save file
  def save_file
    text = to_json
    Dir.mkdir(SAVE_DIR) unless Dir.exist?(SAVE_DIR)
    create_file(text)
  end

  # get valid file name from user and pass to file handler
  def create_file(text)
    user_file = user_input(INPUT_MSGS['file_name'])
    file_name = "#{SAVE_DIR}/#{user_file}.TXT"
    handle_file_errors(file_name, text)
  end

  # handle file errors
  def handle_file_errors(file_name, text)
    if File.exist?(file_name)
      if user_input(INPUT_MSGS['file_exists']) == OVERRIGHT
        write_file(file_name, text)
      else
        disp_msg(INFO_MSGS['file_not_saved'])
      end
    else
      write_file(file_name, text)
    end
  end

  # write contents to file
  def write_file(file_name, text)
    File.open(file_name, 'w') do |file|
      file.puts text
    end
    disp_msg(INFO_MSGS['file_saved'])
  end

  def to_json(*_args)
    JSON.dump({
                solution_arr: @solution_arr,
                turn: @turn,
                guess_arr: @guess_arr,
                wrong_arr: @wrong_arr,
                resolved_arr: @resolved_arr
              })
  end
end
