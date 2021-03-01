# frozen_string_literal: true

# move class gets user moves and validates
class Turn
  include Common
  include Display

  def initialize
    @turn = 0
    @guess_arr = []
    @resolved_arr = []
    @wrong_arr = []
  end

  # set variables for loaded game
  def load_var(load_hash)
    @wrong_arr = load_hash['wrong_arr']
    @guess_arr = load_hash['guess_arr']
    @turn = load_hash['turn']
    @resolved_arr = load_hash['resolved_arr']
    @solution_arr = load_hash['solution_arr']
  end

  # plays and displays results for each turn, handles invalid entry
  def play_turn(solution_arr)
    char = user_input(INPUT_MSGS['to_play'])
    return false unless char
    return false if duplicate_guess(char)

    if char == GAME_SAVE
      SaveGame.new(solution_arr, @turn, @wrong_arr, @guess_arr, @resolved_arr)
    else
      user_turn(solution_arr, char)
      display_turn_results
    end
  end

  # correct guess update resolved else update wrong array
  def user_turn(solution_arr, char)
    if solution_arr.any?(char)
      @resolved_arr = resolve_guess(solution_arr, update_guess_arr(char))
    else
      wrong_guess(char)
    end
  end

  # check not dupliacte
  def duplicate_guess(char)
    if @resolved_arr.any?(char) || @wrong_arr.any?(char)
      disp_msg(ERR_MSGS['duplicate_letter'])
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
    disp_wrong_letters(@wrong_arr) if @wrong_arr.length.positive?
    disp_turns(@turn)
  end

  def create_resolved_arr(solution_arr)
    solution_arr.each { @resolved_arr.push('_') }
    @resolved_arr
  end

  def update_guess_arr(char)
    @guess_arr.push(char)
  end

  # update resolved array
  def resolve_guess(solution_arr, guess_arr)
    guess_arr.each do |guess|
      solution_arr.each_with_index do |item, index|
        @resolved_arr[index] = guess if guess == item
      end
    end
    @resolved_arr
  end

  def game_over(solution_arr)
    if @resolved_arr.none?('_')
      disp_msg(INFO_MSGS['game_won'])
      true
    elsif @turn == GAME_LENGTH
      disp_game_lost(solution_arr)
      true
    else
      false
    end
  end
end
