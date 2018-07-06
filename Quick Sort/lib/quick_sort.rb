require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = rand(array.length - 1)
    left = []
    right = []
    array.each_index do |idx|
      next if idx == pivot
      if array[idx] < array[pivot]
        left.push(array[idx])
      elsif array[idx] > array[pivot]
        right.push(array[idx])
      end
    end
    self.class.sort1(left).concat([array[pivot]]).concat(self.class.sort1(right))
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new{|el,el2| el <=> el2}
    if start < length
      pivot = self.partition(array,start,length, &prc)
      self.sort2!(array,start, pivot - 1)
      self.sort2!(array,pivot + 1, length-pivot)
    end
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new{|el,el2| el <=> el2}
    counter = start
    pivot = start
    (start...start+length).each do |idx|
      if prc.call(array[idx], array[pivot]) == - 1
        counter += 1
        array[counter], array[idx] = array[idx], array[counter]
      end
    end
    array[counter],array[pivot] = array[pivot], array[counter]


    counter
  end
end
