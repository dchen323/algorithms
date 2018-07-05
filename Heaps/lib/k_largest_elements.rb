require_relative 'heap'
require 'byebug'

def k_largest_elements(array, k)
  prc ||= Proc.new {|el,el2| -1 * (el <=> el2)}
  (0...array.length).each do |idx|
    BinaryMinHeap.heapify_up(array,idx,&prc)
  end
  idx = array.length - 1
  while idx > 0
    array[0], array[idx] = array[idx], array[0]
    idx -= 1
    BinaryMinHeap.heapify_down(array,0,idx, &prc)
  end
  array.drop(array.length - k)
end
