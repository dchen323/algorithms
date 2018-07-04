require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    linked_list = @store[key.hash % num_buckets]
    if include?(key)
      linked_list.update(key,val)
    else
      resize! if @count == num_buckets
      node = linked_list.first
      new_node = Node.new(key,val)
      until node.next == nil
        node = node.next
      end
      new_node.next = node
      new_node.prev = node.prev
      node.prev.next = new_node
      node.prev = new_node
      @count += 1
    end
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    if include?(key)
      @store[key.hash % num_buckets].remove(key)
      @count -= 1
    end
  end

  def each(&prc)
     @store.each do |linked_list|
       linked_list.each do |node|
         prc.call(node.key, node.val)
       end
     end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store
    @store = Array.new(num_buckets * 2){LinkedList.new}
    @count = 0
    temp.each do |linked_list|
      linked_list.each do |node|
        set(node.key, node.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
