# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to
require 'byebug'
require_relative 'graph'
require_relative 'topological_sort'


def install_order(arr)
  list_el = []
  graph = []
  top = []
  arr.each do |el|
    list_el.push(el[0]) unless list_el.include?(el[0])
    graph.push(Edge.new(Vertex.new(el[1]), Vertex.new(el[0])))
  end

  sorted = []
  (1..list_el.max).each do |idx|
    sorted.push(idx) unless list_el.include?(idx)
  end

  graph.each do |task|
    if task.from_vertex.in_edges.empty?
      top.push(task.from_vertex)
    end
  end

  until top.empty?
    current = top.shift
    sorted << current.value unless sorted.include?(current.value)
    current.out_edges.each do |edge|
      edge.to_vertex.in_edges.delete(edge)
      if edge.to_vertex.in_edges.empty?
        top.push(edge.to_vertex)
      end
    end
  end
  sorted
end

#inclass #install_order

def install_order(arr)
  max = 0
  independent = []
  vertices = {}

  arr.each do |tuple|
    vertices[tuple[0]] = Vertex.new(vertices[tuple[0]]) unless vertices[tuple[0]]
    vertices[tuple[1]] = Vertex.new(vertices[tuple[1]]) unless vertices[tuple[1]]
    Edge.new(vertices[tuple[1]], vertices[tuple[0]])

    max = tuple.max if tuple.max > max
  end

  (1..max).each do |i|
    independent.push(i) unless vertices[i]
  end

  independent + topological_sort(vertices.values).map {|v| v.value}
end
