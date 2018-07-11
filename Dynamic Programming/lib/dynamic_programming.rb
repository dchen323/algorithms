require 'byebug'

class DynamicProgramming

  def initialize
    @cache = {}
    @hash = {0 => [[]],
            1 => [[1]],
            2 => [[1,1],[2]]
          }
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

    return @hash[n] if @hash[n]

    (3..n).each do |idx|
      third = @hash[idx-1].map {|el| el + [1]}
      second = @hash[idx-2].map {|el| el + [2]}
      first = @hash[idx-3].map {|el| el + [3]}
      @hash[idx] = first + second + third
    end
    # third = frog_cache_builder(n-1)
    # second = frog_cache_builder(n-2)
    # first = frog_cache_builder(n-3)
    # third = third.map do |perm|
    #   perm + [1]
    # end
    # second = second.map do |perm|
    #   perm + [2]
    # end
    #
    # first = first.map do |perm|
    #   perm +[3]
    # end
    # @hash[n] = first + second + third
    @hash[n]

  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @hash[n] if @hash[n]
    third = frog_hops_top_down_helper(n-1)
    second = frog_hops_top_down_helper(n-2)
    first = frog_hops_top_down_helper(n-3)
    third = third.map do |perm|
      perm + [1]
    end
    second = second.map do |perm|
      perm + [2]
    end

    first = first.map do |perm|
      perm +[3]
    end
    @hash[n] = first + second + third
    @hash[n]

  end

  def super_frog_hops(n, k)
    return [[]] if n == 0
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
