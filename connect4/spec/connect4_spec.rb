# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/turn'
require_relative '../lib/display'
require_relative '../lib/constants'

describe Board do
  # Initialise
  describe '#initialise board' do
    context 'when board class instantiated empty board created' do
      subject(:board_obj) { described_class.new }

      it 'board to be an array' do
        result = board_obj.instance_variable_get(:@board_arr)
        expect(result).to be_a(Array)
      end

      it 'board to be an empty array' do
        result = board_obj.board_arr
        expected = [[],[],[],[],[],[],[]]
        expect(result).to eql(expected)
      end

    end
  end

  describe '#update board' do
    context 'valid update' do
      subject(:board_obj) { described_class.new }

      it 'first update' do
        column = 3
        player = 1
        board_obj.update_board(column, player)
        expected = [[],[],[1],[],[],[],[]]
        result = board_obj.instance_variable_get(:@board_arr)
        expect(result).to eql(expected)
      end

      it 'update column 1' do
        column = 1
        player = 2
        board_obj.update_board(column, player)
        expected = [[2],[],[1],[],[],[],[]]
        result = board_obj.instance_variable_get(:@board_arr)
        expect(result).to eql(expected)
      end

      it 'update column 7' do
        column = 7
        player = 1
        board_obj.update_board(column, player)
        expected = [[2],[],[1],[],[],[],[1]]
        result = board_obj.instance_variable_get(:@board_arr)
        expect(result).to eql(expected)
      end

      it 'update column with entries already' do
        column = 7
        player = 1
        board_obj.update_board(column, player)
        expected = [[2],[],[1],[],[],[],[1, 1]]
        result = board_obj.instance_variable_get(:@board_arr)
        expect(result).to eql(expected)
      end

      it 'update column with 6th item' do
        column = 7
        player = 1
        board_obj.update_board(column, player)
        board_obj.update_board(column, player)
        board_obj.update_board(column, player)
        board_obj.update_board(column, player)
        expected = [[2],[],[1],[],[],[],[1, 1, 1, 1, 1, 1 ]]
        result = board_obj.instance_variable_get(:@board_arr)
        expect(result).to eql(expected)
      end

    end
  end

end


describe Turn do
  describe '#Initialise' do
    context 'when turn object is instantiated' do
      
      subject(:turn_obj) { described_class.new }

      it 'player set to 1' do
        result = turn_obj.player
        expected = 1
        expect(result).to eql(expected)
      end
    end
  end

  describe '#Column full' do
    context 'when column is not full' do
      subject(:turn_obj) { described_class.new }

      it 'column empty' do
        column = 7
        board_arr_test = [[1],[2],[1],[2],[1],[],[]]
        result = turn_obj.column_full?(column, board_arr_test)
        expect(result).to be false
      end

      it 'column not empty' do
        column = 1
        board_arr_test = [[1],[2],[1],[2],[1],[],[]]
        result = turn_obj.column_full?(column, board_arr_test)
        expect(result).to be  false
      end
    end

    context 'when column is full' do
      subject(:turn_obj) { described_class.new }

      it 'column full' do
        column = 7
        board_arr_test = [[1],[2],[1],[2],[1],[],[1,2,1,2,1,2]]
        result = turn_obj.column_full?(column, board_arr_test)
        expect(result).to be true
      end
    end
  end

  describe '#valid column' do
    context 'valid column entered' do
      
      it 'column 1 entered' do
        column = 1 
        
      end

      it 'column 7 entered' do
        
      end

    end
  end

  # 
  
  # check valid user input 
  # describe '#User Input' do

  #   subject(:turn_obj) { described_class.new }


  #   context 'valid user input' do

  #     before do
  #       user_input = '1'
  #       allow(turn_obj).to receive(:gets).and_return(user_input)
  #     end

  #     it 'user inputs 1' do
  #       result = turn_obj.new_turn
  #       expected = 1
  #       expect(result).to eql(expected)
  #     end

  #     it 'user inputs 7' do
  #       result = turn_obj.valid_move
  #       expected = 7
  #       expect(result).to eql(expected)
  #     end
  #   end
  # end


end