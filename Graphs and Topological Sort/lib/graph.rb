class Vertex
  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end

  attr_reader :in_edges, :out_edges, :value
end

class Edge
  def initialize(from_vertex, to_vertex, cost = 1)

  end

  def destroy!

  end
end
