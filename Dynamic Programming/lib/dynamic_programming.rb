require 'byebug'

class DynamicProgramming

  def initialize
    @cache = {}
  end

  def blair_nums(n)
    return n if n < 3
    odd = (n-1) * 2 - 1
    return @cache[n] if @cache[n]
    @cache[n] = blair_nums(n-1) + blair_nums(n-2) + odd
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)
  end

  def frog_cache_builder(n)
    hash = {0 => [[]],
            1 => [[1]],
            2 => [[1,1],[2]]
          }
    return hash[n] if hash[n]
    third = frog_cache_builder(n-1)
    second = frog_cache_builder(n-2)
    first = frog_cache_builder(n-3)
    third.each do |perm|
      perm.push(1)
    end
    second.each do |perm|
      perm.push(2)
    end

    first.each do |perm|
      perm.push(3)
    end
    hash[n] = first + second + third
    hash[n]

  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return [[]] if n == 0
    return [[1]] if n == 1
    return [[1,1], [2]] if n == 2
    third = frog_hops_top_down_helper(n-1)
    second = frog_hops_top_down_helper(n-2)
    first = frog_hops_top_down_helper(n-3)
    third.each do |perm|
      perm.push(1)
    end
    second.each do |perm|
      perm.push(2)
    end

    first.each do |perm|
      perm.push(3)
    end

    first + second + third

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
