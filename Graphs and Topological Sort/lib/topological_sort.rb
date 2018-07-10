require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  top = []
  vertices.each do |task|
    if task.in_edges.empty?
      top.push(task)
    end
  end

  until top.empty?
    current = top.shift
    sorted << current
    current.out_edges.each do |edge|
      edge.delete_vertex(current)
      if edge.to_vertex.in_edges.empty?
        top.push(edge.to_vertex)
      end
    end
  end
  return [] if sorted.length < vertices.length
  sorted
end
