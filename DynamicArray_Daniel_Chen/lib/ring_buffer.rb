require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@length)
    @start_idx = 0
    @end_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length
    @store[(index + @start_idx) % @capacity]
  end

  # O(1)
  def []=(index, val)
    @store[(index + @start_idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @end_idx = (@end_idx - 1) % @capacity
    temp = @store[@end_idx % @capacity]
    @store[@end_idx % @capacity] = nil
    @length -= 1
    # debugger
    temp
  end

  # O(1) ammortized
  def push(val)
    if @length >= @capacity
      resize!
    end
    @store[@end_idx % @capacity] = val
    @length += 1
    @end_idx = (@end_idx + 1) % @capacity
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    temp = @store[@start_idx]
    @store[@start_idx] = nil
    @length -= 1
    @start_idx = (@start_idx + 1) % @capacity
    temp
  end

  # O(1) ammortized
  def unshift(val)
    if @length >= @capacity
      resize!
    end
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    counter = 0
    temp = @store
    @store = StaticArray.new(@capacity * 2)
    while counter < @length do
      @store[counter] = temp[@start_idx]
      @start_idx = (@start_idx + 1) % @capacity
      counter += 1
    end
    @end_idx = @capacity
    @capacity *= 2
    @start_idx = 0
  end
end
