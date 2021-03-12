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

    ins_node(value, @root)
  end

  def ins_node(value, node)
    # look left if value < node value
    if value < node.value
      # if child exists recursive call with that child or add new node and update child link
      node.l_child ? ins_node(value, node.l_child) : node.update_l_child(Node.new(value, nil, nil))
    else
      node.r_child ? ins_node(value, node.r_child) : node.update_r_child(Node.new(value, nil, nil))
    end
  end

  def del_node(value)
    # if empty tree return null
    return if @root.nil?

    # find the node to delete (N)
    node = find_node(value, @root)
    if node
      del_node_rec(node, num_children(node))
    else
      p 'value not found'
    end
  end

  def del_node_rec(node, num_children)
    # get node of parent
    parent = find_parent(@root, node)
    del_no_child(parent, node) if num_children.zero?
    del_one_child(parent, node) if num_children == 1
    del_two_child(node) if num_children == 2
  end

  def del_no_child(parent, node)
    # if deleting root set root value to nil
    if node == @root
      @root.update_value(nil)
    else
      # set parent nodes links to nil
      parent.r_child == node ? parent.update_r_child(nil) : parent.update_l_child(nil)
    end
  end

  def del_one_child(parent, node)
    # get child of node to be deleted
    child_node = node.r_child.nil? ? node.l_child : node.r_child
    # update parent with correct child node
    parent.r_child == node ? parent.update_r_child(child_node) : parent.update_l_child(child_node)
  end

  def del_two_child(node)
    # find next bigest node in right sub tree
    next_biggest = find_next_biggest(node)
    # update value of node to delete with next biggest value
    node.update_value(next_biggest.value)
    # delete next biggest node (now duplicate) with recursive call
    del_node_rec(next_biggest, num_children(next_biggest))
  end

  def find_next_biggest(node)
    # identify because it has no left child
    node.l_child.nil? ? node : find_next_biggest(node.r_child)
  end

  def find(value)
    node = find_node(value, @root)
    node.nil? ? 'value not found' : node
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

  def find_parent(parent, child)
    # if value matches the root return nil
    return nil if child.value == @root.value

    # check if parent is parent of node
    return parent if found_parent(parent, child)

    # look left for smaller value or right
    if child.value < parent.value
      # check if node is parent of left child
      find_parent(parent.l_child, child)
    else
      find_parent(parent.r_child, child)
    end
  end

  def found_parent(parent, child)
    parent.l_child == child || parent.r_child == child ? true : false
  end

  def num_children(node)
    count = 0
    count += 1 if node.r_child
    count += 1 if node.l_child
    count
  end

  def level_order
    queue_arr = []
    return queue_arr if @root.nil?

    p order_queue_iter(queue_arr.push(@root))
    p order_queue_rec(queue_arr.push(@root), [])
  end

  def order_queue_rec(queue_arr, res_arr)
    return res_arr if queue_arr.empty?

    queue_arr.push(queue_arr[0].l_child) if queue_arr[0].l_child
    queue_arr.push(queue_arr[0].r_child) if queue_arr[0].r_child
    res_arr.push(queue_arr.shift.value)
    order_queue_rec(queue_arr, res_arr)
  end

  def order_queue_iter(queue_arr)
    res_arr = []
    # while queue not empty add front element to results
    until queue_arr.empty?
      # and add child values to queue if they exist
      queue_arr.push(queue_arr[0].l_child) if queue_arr[0].l_child
      queue_arr.push(queue_arr[0].r_child) if queue_arr[0].r_child
      res_arr.push(queue_arr.shift.value)
    end
    res_arr
  end

  # pre order root, left then right
  def pre_order
    # return empty array if roo is nil
    return [] if @root.nil?

    order_rec(@root, [], 'pre')
  end

  # post order left, right, then root
  def post_order
    return [] if @root.nil?

    order_rec(@root, [], 'post')
  end

  def children?(node)
    node.l_child || node.r_child ? true : false
  end

  # in order left, root, then right
  def in_order
    return [] if @root.nil?

    order_rec(@root, [], 'in')
  end

  def order_rec(node, res_arr, mode)
    res_arr.push(node.value) if mode == 'pre'
    # process left sub tree
    order_rec(node.l_child, res_arr, mode) if node.l_child
    # process root
    res_arr.push(node.value) if mode == 'in'
    # process right sub tree
    order_rec(node.r_child, res_arr, mode) if node.r_child
    res_arr.push(node.value) if mode == 'post'
    res_arr
  end

  def height(node)
    height = 0
    # check if node has no children
    return nil unless @root
    return height unless children?(node)

    height_rec(node, height)
  end

  def height_rec(node, height)
    return height unless children?(node)

    height += 1
    height_l = height_rec(node.l_child, height) if node.l_child
    height_r = height_rec(node.r_child, height) if node.r_child

    height_l = 0 if height_l.nil?
    height_r = 0 if height_r.nil?
    height_l >= height_r ? height_l : height_r
  end
end

# logic to create nodes
class Node
  attr_reader :r_child, :l_child, :value

  def initialize(value, l_child, r_child)
    @l_child = l_child
    @r_child = r_child
    @value = value
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
arr = [1, 2, 4, 5]
tree = Tree.new(arr)
# tree.insert(25)
# tree.del_node(101)
# tree.del_node(2)
# tree.find(2)
# p tree.root.r_child.r_child.value
# p tree.level_order
# p tree.in_order
# p tree.post_order
# p tree.pre_order
p tree.height(tree.root)
