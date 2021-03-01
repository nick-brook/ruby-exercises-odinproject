# frozen_string_literal: true

require_relative 'display'
require 'json'

# module handling loading of saved game files
module LoadGame
  include Common
  include Display

  def initialize; end

  # returns file to load
  def file_to_load
    if Dir.exist?(SAVE_DIR)
      file_arr = Dir.children("#{SAVE_DIR}/")
      get_file_choice(file_arr)
    else
      disp_msg(INFO_MSGS['no_files'])
      false
    end
  end

  # display list of files for uuser to choose
  def get_file_choice(file_arr)
    loop do
      disp_file_arr(file_arr)
      int = gets.chop.to_i
      if int >= 1 && int <= file_arr.length
        return file_arr[int - 1]
      else
        disp_msg(ERR_MSGS['invalid_file_num'])
        false
      end
    end
  end

  def json_load(file_name)
    JSON.parse File.read("#{SAVE_DIR}/#{file_name}")
  end
end
