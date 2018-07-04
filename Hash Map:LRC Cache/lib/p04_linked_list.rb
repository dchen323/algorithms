require 'byebug'

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    start_node = @head
    until start_node.key == key || start_node.next == nil
      start_node = start_node.next
    end
    if start_node.next
      start_node.val
    end
  end

  def include?(key)
    start_node = @head
    until start_node.next == nil || start_node.key == key
      start_node = start_node.next
    end
    start_node.key == key
  end

  def append(key, val)
    new_node = Node.new(key,val)
    start_node = @head
    until start_node.next == nil
      start_node = start_node.next
    end
    new_node.next = start_node
    new_node.prev = start_node.prev
    start_node.prev.next = new_node
    start_node.prev = new_node
  end

  def update(key, val)
    start_node = @head
    until start_node.key == key || start_node.next == nil
      start_node = start_node.next
    end
    if start_node.next
      start_node.val = val
    end
  end

  def remove(key)
    start_node = @head
    until start_node.key == key || start_node.next == nil
      start_node = start_node.next
    end
    if start_node.next
      start_node.prev.next = start_node.next
      start_node.next.prev = start_node.prev
    end
  end

  def each(&prc)
    start_node = self.first
    each_arr = []
    until start_node == @tail
      each_arr << prc.call(start_node)
      start_node = start_node.next
    end
    each_arr
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
