# frozen_string_literal: true

require_relative '../lib/main'
require_relative '../lib/player'
require_relative '../lib/display'

describe Player do
  # Initialise
  describe '#initialise' do
    context 'when class instantiated' do
      subject(:player) { described_class.new }

      it 'player is set to "X"' do
        result = player.next
        expect(result).to eql('X')
      end
    end
  end

  # Initialise
  describe '#change player' do
    context 'change player after each turn' do
      subject(:player) { described_class.new }

      #  if player is X expect it to be changed to O
      it 'when player is "X"' do
        #arrange
        curr_player = 'X'
        #act
        result = player.change_player(curr_player)
        #assert
        expect(result).to eql('O')
      end

      #  if player is X expect it to be changed to O
      it 'when player is "O"' do
        #arrange
        curr_player = 'O'
        #act
        result = player.change_player(curr_player)
        #assert
        expect(result).to eql('X')
      end

      #  if player is X expect it to be changed to O
      it 'when player is non valid' do
        #arrange
        curr_player = '1'
        #act
        result = player.change_player(curr_player)
        #assert
        expect(result).to eql('X')
      end

    end
  end

end



describe Move do

  # in_range? method
  describe '#in range' do
    context 'checking range' do

      subject(:range_obj) { described_class.new }

      it 'when move is 4 in range' do
        #arrange
        test_move = 4
        #act
        result = range_obj.in_range?(test_move)
        #assert
        expect(result).to be true
      end

      it 'when move is 1 valid limit' do
        #arrange
        test_move = 1
        #act
        result = range_obj.in_range?(test_move)
        #assert
        expect(result).to be true
      end

      it 'when move is 9 valid limit' do
        #arrange
        test_move = 9
        #act
        result = range_obj.in_range?(test_move)
        #assert
        expect(result).to be true
      end

      it 'when move is 10 invalid' do
        #arrange
        test_move = 10
        #act
        result = range_obj.in_range?(test_move)
        #assert
        expect(result).to be false
      end

      it 'when move is 0 invalid' do
        #arrange
        test_move = 0
        #act
        result = range_obj.in_range?(test_move)
        #assert
        expect(result).to be false
      end

    end
  end

  # duplicate method
  describe '#empty_square?' do
    context 'check if move already taken' do

      subject(:duplicate_obj) { described_class.new }

      it 'when board entry is availabe' do
        test_board_entry = ' '
        result = duplicate_obj.empty_square?(test_board_entry)
        expect(result).to be true
      end

      it 'when board entry is X' do
        test_board_entry = 'X'
        result = duplicate_obj.empty_square?(test_board_entry)
        expect(result).to be false
      end

      it 'when board entry is O' do
        test_board_entry = 'O'
        result = duplicate_obj.empty_square?(test_board_entry)
        expect(result).to be false
      end

    end
  end

  describe '#valid move' do 
    context 'valid move' do
      subject(:valid_move_obj) { described_class.new }

      #  if player is X expect it to be changed to O
      it 'when move is 2 and board entry is " "' do
            #arrange
            test_move = 2
            board_entry = ' '
            #act
            result = valid_move_obj.valid_move(test_move, board_entry)
            #assert
            expect(result).to be true
      end

      it 'when move is 1 (limit) and board entry is " "' do
        #arrange
        test_move = 1
        board_entry = ' '
        #act
        result = valid_move_obj.valid_move(test_move, board_entry)
        #assert
        expect(result).to be true
      end

      it 'when move is 9 (limit) and board entry is " "' do
        #arrange
        test_move = 9
        board_entry = ' '
        #act
        result = valid_move_obj.valid_move(test_move, board_entry)
        #assert
        expect(result).to be true
      end

    end
  end

  context 'invalid moves' do
    subject(:invalid_move_obj) { described_class.new }
    it 'when move is invalid (0) and board square is empty' do
      test_move = 0
      board_entry = ' '
      result = invalid_move_obj.valid_move(test_move, board_entry)
      expect(result).to be false
    end

    it 'when move is valid (4) and board square is not empty' do
      test_move = 4
      board_entry = 'X'
      result = invalid_move_obj.valid_move(test_move, board_entry)
      expect(result).to be false
    end

    it 'when move is invalid (24) and board square is not empty' do
      test_move = 24
      board_entry = '@'
      result = invalid_move_obj.valid_move(test_move, board_entry)
      expect(result).to be false
    end

  end
end

