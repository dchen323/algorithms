# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require 'byebug'

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max = []
  end

  def enqueue(val)
    update_max(val)
    @store.push(val)
  end

  def dequeue
    check_max = @store.shift
    if check_max == @max.first
      @max.shift
    end
  end

  def update_max(val)
    while @max.length > 0 && val > @max.last
      @max.pop
    end
    @max.push(val)
  end

  def max
    @max.first
  end

  def length
    @store.length
  end

end
