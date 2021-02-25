# frozen_string_literal: true

# player class creates object that contains player
module Common

  def user_input(message, err_message, regex)
    first = true
    loop do
      if first 
        puts message
        first = false
      end
      char = gets.chop.upcase
      char.match?(regex) ? (return char) : disp_msg(err_message)
    end
  end

end


