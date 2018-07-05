require_relative "heap"
require 'byebug'

class Array
  def heap_sort!
    prc ||= Proc.new {|el1,el2| -1 * (el1 <=> el2)}
    (0...length).each do |idx|
      BinaryMinHeap.heapify_up(self,idx,&prc)
    end
    idx = self.length - 1
    while idx > 0
      self[0], self[idx] = self[idx], self[0]
      idx -= 1
      BinaryMinHeap.heapify_down(self,0,idx, &prc)
    end

  end
end
