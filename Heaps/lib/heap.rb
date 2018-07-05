require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
    @count = 0
    @prc = prc
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    value = @store.pop
    self.class.heapify_down(@store,0)
    debugger
    value
  end

  def peek
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(store,@count)
    @count += 1
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
    prc ||= Proc.new {|el1,el2| el1 <=> el2}
    index = parent_index * 2
    child_one = array[index + 1] if index + 1 <= len
    child_two = array[index + 2] if index + 2 <= len
    until (child_one == nil && child_two == nil) ||
          (child_one && !child_two && prc.call(array[parent_index],child_one) == -1) ||
          (prc.call(array[parent_index],child_one) == -1 && prc.call(array[parent_index],child_two) == -1)
            if child_two
              swap_index = prc.call(child_one,child_two) == -1 ? index + 1 : index + 2
            else
              swap_index = index + 1
            end
            array[parent_index], array[swap_index] = array[swap_index], array[parent_index]
            parent_index = swap_index
            index = parent_index * 2
            child_one = index + 1 <= len ? array[index + 1] : nil
            child_two = index + 2 <= len ? array[index + 2] : nil
   end
   array
  end

  def self.heapify_up(array, child_index, len = array.length, &prc)
    prc ||= Proc.new {|el1,el2| el1 <=> el2}
    parent_index = self.parent_index(child_index) unless child_index == 0
    until child_index == 0 || prc.call(array[child_index],array[parent_index]) == 1
      array[child_index], array[parent_index] = array[parent_index], array[child_index]
      child_index = parent_index
      parent_index = self.parent_index(child_index) unless child_index == 0
    end
    array
  end
end
