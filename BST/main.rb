# frozen_string_literal: true

# logic to manage link list nodes
class Tree
  attr_reader :root, :input_data

  def initialize(arr)
    @input_data = arr.uniq.sort
    @root = build_tree(input_data)
  end

  def build_tree(arr)
    # base case - empty array
    return nil if arr.empty?

    mid_num = arr.length / 2
    # define root and create node with recursive call using left and right arrays
    root = arr[mid_num]
    Node.new(root, build_tree(arr[0...mid_num]), build_tree(arr[(mid_num + 1)..-1]))
  end

  def insert(value, node = @root)
    # if value is node value (duplicate) return
    return if value == node.value

    # look left if value < node value, if child exists recursive call with that child or add new node and update link
    if value < node.value
      node.l_child ? insert(value, node.l_child) : node.update_l_child(Node.new(value, nil, nil))
    else
      node.r_child ? insert(value, node.r_child) : node.update_r_child(Node.new(value, nil, nil))
    end
  end

  def del_node(value)
    # if empty tree return null
    return if @root.nil?

    node = find_node(value, @root)
    node ? del_node_rec(node, num_children(node)) : (p 'value not found')
  end

  # recursive method calls relevant method for number of children
  def del_node_rec(node, num_children)
    del_no_child(node) if num_children.zero?
    del_one_child(node) if num_children == 1
    del_two_child(node) if num_children == 2
  end

  def del_no_child(node)
    # if deleting root set root value to nil or update parent node links
    node == @root ? @root.update_value(nil) : update_parent(node, nil)
  end

  # confirm which child to delete, update root if deleting root else update parent links
  def del_one_child(node)
    child_node = node.r_child.nil? ? node.l_child : node.r_child
    node == @root ? @root = child_node : update_parent(node, child_node)
  end

  # gets parent of node and updates pointer to child node
  def update_parent(node, value)
    parent = find_parent(node)
    return if parent.nil?

    parent.r_child == node ? parent.update_r_child(value) : parent.update_l_child(value)
  end

  def del_two_child(node)
    min_r_subtree = find_min_r_subtree(node.r_child)
    # update node with new value
    node.update_value(min_r_subtree.value)
    # delete duplicate node
    del_node_rec(min_r_subtree, num_children(min_r_subtree))
  end

  # find min value in right sub tree - identify because it has no left child
  def find_min_r_subtree(node)
    node.l_child ? find_min_r_subtree(node.l_child) : node
  end

  # return node if matches search value, else look in relevant subtree (recursive)
  def find_node(value, node = @root)
    return nil if node.nil?
    return node if node.value == value

    value < node.value ? find_node(value, node.l_child) : find_node(value, node.r_child)
  end

  # return parent node if found or look in relevant subtree - recursive
  def find_parent(child, parent = @root)
    return nil if child == @root

    # check if parent is parent of node
    return parent if found_parent(parent, child)

    child.value < parent.value ? find_parent(child, parent.l_child) : find_parent(child, parent.r_child)
  end

  def found_parent(parent, child)
    return true if parent.nil?

    parent.l_child == child || parent.r_child == child ? true : false
  end

  def num_children(node)
    count = 0
    count += 1 unless node.r_child.nil?
    count += 1 unless node.l_child.nil?
    count
  end

  # display arr or values traversing tree breadth first (both iterative ad recursive methods)
  def level_order
    queue_arr = []
    return queue_arr if @root.nil?

    order_queue_iter(queue_arr.push(@root))
    # p order_queue_rec(queue_arr.push(@root), [])
  end

  # recursive method for breadth first search
  def order_queue_rec(queue_arr, res_arr)
    return res_arr if queue_arr.empty?

    queue_arr.push(queue_arr[0].l_child) if queue_arr[0].l_child
    queue_arr.push(queue_arr[0].r_child) if queue_arr[0].r_child
    res_arr.push(queue_arr.shift.value)
    order_queue_rec(queue_arr, res_arr)
  end

  # iterative method for breadth first search
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
    return [] if @root.nil?

    order_rec(@root, [], 'pre')
  end

  # post order left, right, then root
  def post_order
    return [] if @root.nil?

    order_rec(@root, [], 'post')
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

  def children?(node)
    return false if node.nil?

    node.l_child || node.r_child ? true : false
  end

  # recursive method to compare
  def height(node, height = 0)
    # no tree
    return nil unless @root

    # has no children - reached bottom of tree
    return height unless children?(node)

    # recursive call if node has children
    height_l = height(node.l_child, height + 1) if node.l_child
    height_r = height(node.r_child, height + 1) if node.r_child
    nil_to_zero(height_l) >= nil_to_zero(height_r) ? height_l : height_r
  end

  def depth(node, depth = 1)
    return nil unless @root
    return 0 if node == @root

    parent = find_parent(node)
    return depth if parent == @root

    depth(parent, depth + 1)
  end

  # calculate height of left and right child and compare
  def balanced?
    return true if @root.nil?

    height_l = @root.l_child.nil? ? 0 : height(@root.l_child)
    height_r = @root.r_child.nil? ? 0 : height(@root.r_child)
    height_l - height_r > 1 || height_r - height_l > 1 ? false : true
  end

  def nil_to_zero(num)
    num = 0 if num.nil?
    num
  end

  def rebalance
    @input_data = in_order
    @root = build_tree(@input_data)
  end

  def print_orders
    puts "tree - level order #{level_order}"
    puts "tree - pre order #{pre_order}"
    puts "tree - post order #{post_order}"
    puts "tree - in order #{in_order}"
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

# driver script

tree = Tree.new(Array.new(15) { rand(1..100) })
# tree = Tree.new([1, 2, 4, 5, 8, 12, 56, 78, 89])
tree.balanced? ? (puts 'tree is balanced') : (puts 'tree is unbalanced')
tree.print_orders
tree.balanced? ? (puts 'tree is balanced') : (puts 'tree is unbalanced')
tree.insert(110)
tree.insert(112)
tree.insert(118)
tree.balanced? ? (puts 'tree is balanced') : (puts 'tree is unbalanced')
tree.rebalance
tree.balanced? ? (puts 'tree is balanced') : (puts 'tree is unbalanced')
tree.print_orders
tree.del_node(8)
tree.print_orders
