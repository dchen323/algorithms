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
      if value > node.value
        node.right = BSTNode.new(value)
      elsif value < node.value
        node.left = BSTNode.new(value)
      end
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
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end

  attr_reader :root

  private
  # optional helper methods go here:
  def set_root(value)
    @root = BSTNode.new(value)
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
end
