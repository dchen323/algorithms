require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(length)
  end

  # O(1)
  def [](index)
    if @length <= index
      raise "index out of bounds"
    end
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    if @length == 0
      raise "index out of bounds"
    end
    @length -= 1
    temp = @store[@length]
    @store[@length] = nil
    temp
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity
      resize!
    end
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0
      raise "index out of bounds"
    end
    temp = @store[0]
    counter = 1
    while counter < @length do
      @store[counter - 1] = @store[counter]
      counter += 1
    end
    @length -= 1
    temp
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    @length += 1
    if @length >= @capacity
      resize!
    end
    temp = @store
    counter = @length
    while counter > 0 do
      @store[counter] = temp[counter - 1]
      counter -= 1
    end
    @store[0] = val


  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    counter = 0
    temp = @store
    @store = StaticArray.new(@capacity * 2)
    while counter < @length do
      @store[counter] = temp[counter]
      counter += 1
    end
    @capacity *= 2
  end
end
