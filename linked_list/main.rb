# frozen_string_literal: true

# logic to manage link list nodes
class LinkedList
  # attr_reader :head, :tail

  def initialize
    # create head node and tail node set nodes to 2
    @nodes = 2
    @head = Node.new(nil, nil)
    @tail = Node.new(nil, nil)
  end

  def append(value)
    # set pointer to head pointer
    pointer = @head
    # find node which points to nil (i.e last node)
    pointer = pointer.next_node until pointer.next_node.nil?
    # update last node pointer to new node.  New node created with value and pointing to tail (nil)
    pointer.update_next_node(Node.new(value, nil))
    @nodes += 1
  end

  def prependnode(value)
    # get next node for head
    head_next_node = @head.next_node
    # update head next node to new node, and new node pointer to old head pointer
    @head.update_next_node(Node.new(value, head_next_node))
    @nodes += 1
  end

  attr_reader :nodes

  def node_at_index(index)
    # check index is valid
    if index >= 0 && index < @nodes
      next_node = @head.next_node
      2.upto(index) { next_node = next_node.next_node }
      next_node
    else
      "invalid index - must be between 1 and #{@nodes}"
    end
  end

  def pop_node
    # only valid command for at least 3 nodes
    return unless @nodes >= 3

    # update next node for node 2 from end to point at tail
    node_at_index(@nodes - 3).update_next_node(nil)
    node_at_index(@nodes - 2)
    @nodes -= 1
  end

  # loop through data structure until values match
  def list_contains?(value)
    1.upto(@nodes - 2) do |index|
      return true if node_at_index(index).value == value
    end
    false
  end

  def list_find(value)
    1.upto(@nodes - 2) do |index|
      return index if node_at_index(index).value == value
    end
    nil
  end

  def list_to_s
    arr = []
    return unless @nodes >= 3

    1.upto(@nodes - 2) do |index|
      arr.push("( #{node_at_index(index).value} )")
    end
    p arr.join(' -> ')
  end

  def insert_at_index(value, index)
    # get next node of index - 1
    prev_node_next = node_at_index(index - 1).next_node
    # create new node with prev node next
    node_at_index(index - 1).update_next_node(Node.new(value, prev_node_next))
    @nodes += 1
  end

  def remove_at_index(index)
    del_node_next = node_at_index(index).next_node
    if index == 1
      @head.update_next_node(del_node_next)
    else
      node_at_index(index - 1).update_next_node(del_node_next)
    end
    @nodes -= 1
  end
end

# logic to create nodes
class Node
  attr_reader :value, :next_node

  def initialize(value, next_node)
    @next_node = next_node
    @value = value
  end

  def update_next_node(next_node)
    @next_node = next_node
  end

  def update_value
    @value = value
  end
end

linked_list = LinkedList.new
linked_list.append('y')
linked_list.append('x')
linked_list.prependnode('node prepended')
linked_list.insert_at_index('added at index 2 ', 2)
linked_list.insert_at_index('added at index 4 ', 4)
linked_list.remove_at_index(2)
linked_list.remove_at_index(1)
# p linked_list.head.next_node.next_node.value
linked_list.pop_node
# p linked_list.node_at_index(1)
p linked_list.list_contains?('ya')
p linked_list.list_find('yx')
linked_list.list_to_s
