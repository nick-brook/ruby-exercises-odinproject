# frozen_string_literal: true

# logic to manage link list nodes
class Tree
  MOVES = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]].freeze

  def initialize(position, target)
    @sol_arr = []
    # if position is target = no move
    position == target ? (puts 'no move needed - target is current position') : create_tree(position, target)
  end

  def create_tree(position, target)
    # initialize queue and create first node
    queue_arr = []
    continue = true
    queue_arr = add_next_moves(position, queue_arr, Node.new(position, nil))

    # loop until first item in queue is the target
    while continue
      # create new node for the first item in queue, parent node = item parent node
      node = Node.new(queue_arr[0][0], queue_arr[0][1])
      # if the first position in queue is target calculate and display solution
      if queue_arr[0][0] == target
        disp_solution(position, target, calc_solution(node))
        continue = false
      # else add next moves and delete first queue item
      else
        queue_arr = add_next_moves(queue_arr[0][0], queue_arr, node)
        queue_arr.shift
      end
    end
  end

  def disp_solution(position, target, disp_arr)
    puts "The fastest way from #{position} to #{target} is #{disp_arr.length - 1} moves.. \n #{disp_arr.reverse}"
  end

  def calc_solution(node, disp_arr = [])
    disp_arr.push(node.value)
    node.parent.nil? ? disp_arr : calc_solution(node.parent, disp_arr)
  end

  # add valid next moves to queue
  def add_next_moves(position, queue_arr, parent_node)
    MOVES.each do |item|
      new_pos = [position[0] + item[0], position[1] + item[1]]
      if valid_move(new_pos)
        queue_arr.push([new_pos, parent_node])
        @sol_arr.push(new_pos)
      end
    end
    queue_arr
  end

  # checks new position is inside board and not duplicate
  def valid_move(new_pos)
    return false if !new_pos[0].positive? || new_pos[0] > 8
    return false if !new_pos[1].positive? || new_pos[1] > 8
    return false if @sol_arr.include?(new_pos)

    true
  end

  def node_exists?(position)
    @sol_arr.include?(position)
  end
end

# creates node for each move
class Node
  attr_reader :parent, :value

  def initialize(value, parent)
    @value = value
    @parent = parent
  end
end

Tree.new([1, 2], [1, 8])
