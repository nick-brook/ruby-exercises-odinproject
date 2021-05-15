# frozen_string_literal: true

# module prompts user with relevant message, tests against supplied regex and display error for invalid input
module Common
  def user_input(message)
    first = true
    loop do
      if first
        puts message[0]
        first = false
      end
      char = gets.chop.upcase
      char.match?(message[1]) ? (return char) : disp_msg(message[2])
    end
  end
end
