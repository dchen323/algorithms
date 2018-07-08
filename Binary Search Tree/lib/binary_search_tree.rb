# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'
require 'byebug'

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if !@root
      set_root(value)
    else
      node = traverse_tree(value)
      add_node(node,value)
    end
  end

  def find(value, tree_node = @root)
    until tree_node == nil || tree_node.value == value
        if tree_node.value > value
          tree_node = tree_node.left
        else
          tree_node = tree_node.right
        end
    end
    tree_node
  end

  def delete(value)
    node = find(value)
    if node == root
      @root = nil
    elsif node
      remove_node(node)
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    find_replacement_node(tree_node)
  end

  def depth(tree_node = @root)
    find_depth(tree_node)
  end

  def is_balanced?(tree_node = @root)
    left_count = find_depth(tree_node.left)
    right_count = find_depth(tree_node.right)
    (left_count - right_count).abs < 1
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end

  attr_reader :root

  private
  # optional helper methods go here:
  def set_root(value)
    @root = BSTNode.new(value)
  end

  def add_node(node,value)
    if value > node.value
      node.right = BSTNode.new(value)
      node.right.parent = node
    elsif value < node.value
      node.left = BSTNode.new(value)
      node.left.parent = node
    end
  end

  def find_depth(node,count = 0)
    return count if !node.left && !node.right
    count += 1
    left_count = 0
    right_count = 0
    if node.left
      left_count = find_depth(node.left, count)
    end
    if node.right
      right_count = find_depth(node.right, count)
    end
    [left_count, right_count].max
  end

  def traverse_tree(value)
    start_node = @root
    until start_node.left == nil && start_node.value > value ||
          start_node.right == nil && start_node.value < value
            if start_node.value > value
              start_node = start_node.left
            elsif start_node.value < value
              start_node = start_node.right
            end
    end
    start_node
  end

  def find_replacement_node(node)
    until node.right == nil
      node = node.right
    end
    node
  end

  def reset_children(node,deleted_node)
    if node.left
      remove_node(node)
    end
    node.right = deleted_node.right
    deleted_node.right.parent = node
  end

  def remove_node(node)
    if node.left && node.right
      replacement_node = find_replacement_node(node.left)
      reset_children(replacement_node,node)
    elsif node.left || node.right
      replacement_node = node.left ? node.left : node.right
    else
      replacement_node = nil
    end
    if replacement_node
      replacement_node.parent = node.parent
    end
    if node.parent.value < node.value
      node.parent.right = replacement_node
    elsif node.parent.value > node.value
      node.parent.left = replacement_node
    end
  end
end
