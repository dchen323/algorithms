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

  end

  def frog_cache_builder(n)

  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

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
