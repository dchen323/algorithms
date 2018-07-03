require 'byebug'


class MaxIntSet
  def initialize(max)
    @array = Array.new(max)
    @max = max
  end

  def insert(num)
    is_valid?(num)
    @array[num] = num
  end

  def remove(num)
    @array[num] = nil
  end

  def include?(num)
    @array[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num < 0 || num > @max
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets].push(num)
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count == num_buckets
      resize!
    end
    @store[num % num_buckets].push(num)
    @count += 1
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = Array.new(num_buckets * 2){Array.new}
    temp_size = num_buckets * 2
    @store.each do |row|
      row.each do |value|
        temp[value % temp_size].push(value)
      end
    end
    @store = temp
  end
end
