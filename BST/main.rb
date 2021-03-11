# frozen_string_literal: true

# require 'pry'

# logic to manage link list nodes
class Tree
  attr_reader :root

  def initialize(arr)
    @root = build_tree(arr.uniq.sort)
    @nodes = 0
  end

  def build_tree(arr)
    mid_num = arr.length / 2
    # base case - empty array
    return nil if arr.empty?

    # create root, left and right side arrays
    root = arr[mid_num]
    arr_left = arr.slice(0, mid_num)
    arr_right = arr.slice(mid_num + 1, arr.length - mid_num)
    # create node with recursive call using left and right arrays
    Node.new(root, build_tree(arr_left), build_tree(arr_right))
  end

  def insert(value)
    # if value is root (duplicate) return
    return if value == @root.value

    insert_node(value, @root)
  end

  def insert_node(value, curr_node)
    # look left if value < node value
    if value < curr_node.value
      # if child exists recursive call with that child or add new node and update child link
      curr_node.l_child ? insert_node(value, curr_node.l_child) : curr_node.update_l_child(Node.new(value, nil, nil))
    else
      curr_node.r_child ? insert_node(value, curr_node.r_child) : curr_node.update_r_child(Node.new(value, nil, nil))
    end
  end

  def delete_node(value)
    # if empty tree return null
    return if @root.nil?

    # find the node to delete (N)
    node_to_del = find_node(value, @root)

    if node_to_del
      delete_node_rec(node_to_del, get_num_children(node_to_del))
    else
      p 'value not found'
    end
  end

  def delete_node_rec(node_to_del, num_children)
    # get node of parent
    parent_node = find_parent_node(@root, node_to_del)

    # node has one child
    if num_children.zero?
      # if deleting root set root value to nil
      if node_to_del == @root
        @root.update_value(nil)
      else
        # set parent nodes links to nil
        parent_node.r_child == node_to_del ? parent_node.update_r_child(nil) : parent_node.update_l_child(nil)
      end
    end

    if num_children == 1
      # get child of node to be deleted
      child_node = node_to_del.r_child.nil? ? node_to_del.l_child : node_to_del.r_child
      # update parent with correct child node
      parent_node.r_child == node_to_del ? parent_node.update_r_child(child_node) : parent_node.update_l_child(child_node)
    end

    return unless num_children == 2

    # find next bigest node in right sub tree
    next_biggest = find_next_biggest(node_to_del)
    # update value of node to delete with next biggest value
    node_to_del.update_value(next_biggest.value)
    # delete next biggest node (now duplicate) with recursive call
    delete_node_rec(next_biggest, get_num_children(next_biggest))
  end

  def find_next_biggest(node)
    # identify because it has no left child
    node.l_child.nil? ? node : find_next_biggest(node.r_child)
  end

  def find_node(value, node)
    # if value matches the node value return that node
    return node if node.value == value

    # else if value < root look left
    if value < node.value
      return nil if node.l_child.nil?

      find_node(value, node.l_child)
    else
      return nil if node.r_child.nil?

      find_node(value, node.r_child)
    end
  end

  def find_parent_node(parent, child)
    # if value matches the root return nil
    return nil if child.value == @root.value

    # check if parent is parent of node
    return parent if found_parent(parent, child)

    # look left for smaller value or right
    if child.value < parent.value
      # check if node is parent of left child
      find_parent_node(parent.l_child, child)
    else
      find_parent_node(parent.r_child, child)
    end
  end

  def found_parent(parent, child)
    parent.l_child == child || parent.r_child == child ? true : false
  end

  def get_num_children(node_to_del)
    count = 0
    count += 1 if node_to_del.r_child
    count += 1 if node_to_del.l_child
    count
  end
end

# logic to create nodes
class Node
  attr_reader :r_child, :l_child, :value

  def initialize(value, l_child, r_child)
    @l_child = l_child
    @r_child = r_child
    @value = value
    # puts "root #{root}, left child #{l_child}, right child #{r_child},"
  end

  def update_r_child(node)
    @r_child = node
  end

  def update_l_child(node)
    @l_child = node
  end

  def update_value(value)
    @value = value
  end
end

# arr =[1]
arr = [1, 2, 4, 8, 9, 11, 15, 17, 89, 100, 101]
tree = Tree.new(arr)
# tree.insert(25)
tree.delete_node(101)
# tree.delete_node(2)
p tree.root.r_child.r_child.value
