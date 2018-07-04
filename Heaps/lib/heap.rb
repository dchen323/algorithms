require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
  end

  public
  def self.child_indices(len, parent_index)
    child_idx = []
    index = parent_index * 2
    child_idx << index + 1 if index + 1 < len
    child_idx << index + 2 if index + 2 < len
    child_idx
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_index, len = array.length, &prc)
    index = parent_index * 2
    original_root = array[0]
    child_one = array[index + 1]
    child_two = array[index + 2]
    until child_one == nil && child_two == nil ||
          original_root <= child_one && original_root <= child_two
            swap_index = child_one < child_two ? index + 1 : index + 2
            original_root, array[swap_index] = array[swap_index], original_root
            debugger
            parent_idx = swap_index
            index = parent_index * 2
            child_one = array[index + 1]
            child_two = array[index + 2]
   end
   array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
