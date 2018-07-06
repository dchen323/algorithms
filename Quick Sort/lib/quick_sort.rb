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
    return if array.length < 2
    pivot = self.partition(array,start,length)
  end

  def self.partition(array, start, length, &prc)
    counter = start - 1
    (start...array.length - 1).each do |idx|
      if array[idx] < array[-1]
        counter += 1
        array[counter], array[idx] = array[idx], array[counter]
      end
    end
    counter +=1
    array[counter],array[-1] = array[-1], array[counter]

    counter
  end
end
