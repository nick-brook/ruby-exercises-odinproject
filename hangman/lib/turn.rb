# frozen_string_literal: true

require_relative 'display'

# move class gets user moves and validates
class Turn
  include Display, Common

  def initialize(solution_arr)
    @first = true
    @turn = 0
    @guess_arr = []
    @resolved_arr = []
    @wrong_arr = []
    @mode = MODE_PLAY
  end

  def set_load_var(load_hash)
    @wrong_arr = load_hash['wrong_arr']
    @guess_arr = load_hash['guess_arr']
    @turn = load_hash['turn']
    @resolved_arr = load_hash['resolved_arr']
    @first = false
    @mode = MODE_PLAY
    puts "wrong #{@wrong_arr} guess #{@guess_arr} turn #{@turn} resolved #{@resolved_arr}"
    
  end

  # plays and displays results for each turn
  def play_turn(solution_arr)
  
    # initialize and display resolved array
    # first_turn(solution_arr) if @first

    # get user input and stop turn if invalid or duplicate
    char = user_input(@mode)
    return false unless char
    return false if duplicate_guess(char)
    
    if char == GAME_SAVE
      save_game_obj = Save_Game.new(solution_arr, @turn, @wrong_arr, @guess_arr, @resolved_arr)
    else

      # check if char is in array and add to wrong guess if not 
      if solution_arr.any?(char)
        # update and resolve guess array
        @resolved_arr = resolve_guess(solution_arr, update_guess_arr(char))
      else
        wrong_guess(char)
      end
      # display results
      display_turn_results
    end
  end

  # check not dupliacte
  def duplicate_guess(char)
    if @resolved_arr.any?(char) || @wrong_arr.any?(char)
      disp_duplicate 
      true
    else
      false
    end
  end

  def wrong_guess(char)
    @wrong_arr.push(char)
    @turn += 1
  end

  def display_turn_results
    disp_resolved(@resolved_arr)
    disp_wrong_letters(@wrong_arr)  
    disp_turns(@turn)
  end

  def create_resolved_arr(solution_arr)
    solution_arr.each {|x| @resolved_arr.push('_')}
    @resolved_arr
  end

  # get user input returns user guess as an array
  def user_input(mode)
    # get user input
    mode == MODE_PLAY ? disp_to_play : disp_to_save
    char = gets.chop.upcase 
    @mode = MODE_SAVE
    valid_turn(char, mode) ? char : false
  end

  # checks if user has entered a valid 4 digit code, returns true or false
  def valid_turn(char, mode)
    regex = /^[A-Z1]{1}$/
    if char.match?(regex) 
      true
    else
      mode == MODE_PLAY ? disp_invalid_char : disp_invalid_save_char
      false
    end
  end

  def update_guess_arr(char)
    @guess_arr.push(char)
  end

  def resolve_guess(solution_arr, guess_arr)
    # check each guess letter if found in solution add to resolved array
    guess_arr.each do |guess|
      solution_arr.each_with_index do |item, index|
        @resolved_arr[index] = guess if guess == item
      end
    end
    @resolved_arr
  end

  def game_over(solution_arr)
    if !@resolved_arr.any?('_')
      disp_msg(MSGS['game_won'])
      true
    elsif @turn == GAME_LENGTH
      disp_game_lost(solution_arr)
      true
    else
      false
    end
  end
end
