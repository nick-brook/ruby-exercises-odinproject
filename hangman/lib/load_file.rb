# frozen_string_literal: true

require_relative 'display'
require 'json'

module Load_Game
  include Display

  def initialize
  end

  def file_to_load

    # get list of files 
    if Dir.exists?(SAVE_DIR)
      file_arr = Dir.children("#{SAVE_DIR}/")
      get_file_choice(file_arr)
    else
      disp_msg(MSGS['no_files'])
      false
    end
  end

  def get_file_choice(file_arr)
    loop do
      disp_file_arr(file_arr)
      int = gets.chop
      regex = /[#{1}-#{file_arr.length}]/
      if int.match?(regex)
         return file_arr[int.to_i - 1]
      else
         disp_msg(MSGS['invalid_file_num'])
         false
      end
    end
  end

  def json_load(file_name)
    load_hash = JSON.load File.read("#{SAVE_DIR}/#{file_name}")
  end
end