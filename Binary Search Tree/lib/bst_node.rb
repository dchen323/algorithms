class BSTNode
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end
  
  attr_reader :value
  attr_accessor :left, :right, :parent
end
