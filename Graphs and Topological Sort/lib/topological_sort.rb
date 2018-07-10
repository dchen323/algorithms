require_relative 'graph'
require 'byebug'
require 'set'

# Implementing topological sort using both Khan's and Tarian's algorithms
def topological_sort(vertices)
  sorted = []
  top = []
  vertices.each do |task|
    top.push(task) if task.in_edges.empty?
  end

  until top.empty?
    current = top.shift
    sorted << current
    current.out_edges.each do |edge|
      edge.to_vertex.in_edges.delete(edge)
      if edge.to_vertex.in_edges.empty?
        top.push(edge.to_vertex)
      end
    end
  end
  return [] if sorted.length < vertices.length
  sorted
end

#Khan's Algorithms using hash lecture
def topological_sort(vertices)
  queue = [] #same as top
  sorted = []
  in_edge_count = {}
  vertices.each do |vertex|
    in_edge_count[vertex] = vertex.in_edges.count
    queue.push(vertex) if vertex.in_edges.empty?
  end

  until top.empty?
    current = queue.shift
    sorted.push(current)
    current.out_edges.each do |edge|
      to_vert = edge.to_vertex
      in_edge_count[to_vert] -= 1
      top.push(to_vert) if in_edge_count[to_vert] == 0
    end
  end

  sorted.length == vertices.length ? sorted : []
end

#Khan's Algorithms destroying edges lecture

def topological_sort(vertices)
  top = [] #same as top
  sorted = []
  vertices.each do |vertex|
    top.push(vertex) if vertex.in_edges.empty?
  end

  until top.empty?
    current = top.shift
    sorted.push(current)
    current.out_edges.dup.each do |edge|
      to_vert = edge.to_vertex
      top.push(to_vert) if to_vert.in_edges.count <= 1
      edge.destroy!
    end
  end

  sorted.length == vertices.length ? sorted : []
end

#Tarjan's Algorithim(without cycle catching)

def topological_sort(vertices)
  order = []
  explored = Set.new

  vertices.each do |vertex|
    dfs!(order,explored,vertex) unless explored.include?(vertex)
  end

  order
end

def dfs!(order,explored,vertex)
  explored.add(vertex)

  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex
    dfs!(order,explored, to_vertex) unless explored.included?(vertex)
  end

  order.unshift(vertex)
end

#Tarjan's Algorithim(with catching)

def topological_sort(vertices)
  order = []
  explored = Set.new
  temp = Set.new
  cycle = false

  vertices.each do |vertex|
    cycle = dfs!(order,explored,vertex,temp,cycle) unless explored.include?(vertex)
    return [] if cycle
  end

  order
end

def dfs!(order,explored,vertex,temp,cycle)
  return true if temp.include?(vertex)
  temp.add(vertex)

  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex
    cycle = dfs!(order,explored, to_vertex) unless explored.included?(vertex)
    return true if cycle
  end

  explored.add(vertex)
  temp.delete(vertex)
  order.unshift(vertex)
  false
end
