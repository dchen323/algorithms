require 'binary_search_tree'

def kth_largest(tree_node, k)
  sorted_tree = sort_tree(tree_node)
  value = sorted_tree[sorted_tree.length - k]
  find_value(tree_node,value)
end

def sort_tree(tree_node, arr = [])
  return [tree_node.value] if !tree_node.left && !tree_node.right
  if tree_node.left
    arr += sort_tree(tree_node.left)
  end
  arr.push(tree_node.value)
  if tree_node.right
    arr+= sort_tree(tree_node.right)
  end
  arr
end

def find_value(tree_node,value)
  until tree_node == nil || tree_node.value == value
    if tree_node.value > value
      tree_node = tree_node.left
    else
      tree_node = tree_node.right
    end
  end
  tree_node
end
