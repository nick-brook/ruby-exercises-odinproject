# frozen_string_literal: true

# player class creates object that contains player
module Display
  def disp_invalid_move
    puts 'Invalid move. Enter 1 to 9'
  end

  def disp_duplicate_move
    puts 'Move already made! Try again'
  end

  def disp_won
    puts 'Congratulations You Won!'
  end

  def disp_instructions
    p 'Enter Position 1 to 9'
    p '1 is top left - 9 is bottom right'
  end

  def disp_to_play(player)
    puts "#{player} to play"
  end

  def disp_draw
    puts 'Its a draw!'
  end
end
