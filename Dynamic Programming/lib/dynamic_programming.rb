require 'byebug'

class DynamicProgramming

  def initialize
    @cache = {}
    @hash = {0 => [[]],
            1 => [[1]],
            2 => [[1,1],[2]]
          }
    @hash2 = {0 => [[]]}
    @knap = {}
    @maze_cache = {}

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

  def reset_cache
    @hash2 = {0 => [[]]}
  end

  def super_frog_hops(n, k)
    reset_cache #add to pass specs
    return @hash2[n] unless @hash2[n].nil?
    idx = 1
    result = []
    while idx <= k
      k = n if n < k
      result += super_frog_hops(n-idx, k).map {|sub| sub + [idx]}
      idx += 1
    end
    @hash2[n] = result
    @hash2[n]
  end

  def knapsack(weights, values, capacity)
    return 0 if capacity == 0
    (0..capacity).each do |cap|
      soln = []
      (0...values.length).each do |idx|
        if weights[idx] <= cap
          total = values[idx]
          if idx > 0
            temp = values[idx] + @knap[cap - weights[idx]][idx - 1]
            total = total > temp ? total : temp
            final = total > soln[idx - 1] ? total : soln[idx - 1]
            soln[idx] = final > values[idx] ? final : values[idx]
          else
            soln[idx] = total > values[idx] ? total : values[idx]
          end
        elsif weights[idx] > cap
          soln[idx] = idx == 0 ? 0 : soln[idx - 1]
        end
      end
      @knap[cap] = soln
    end
    @knap[capacity].max
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
    build_cache(start_pos)
    solve_maze(maze,start_pos,end_pos)
    find_path(end_pos)
  end

  def solve_maze(maze,start_pos,end_pos)
    return true if start_pos == end_pos
    get_moves(maze,start_pos).each do |new_loc|
      unless @maze_cache.keys.include?(new_loc)
        @maze_cache[new_loc] = start_pos
        solve_maze(maze,new_loc_end_pos)
    end
  end

  def find_path(end_pos)
    path = []
    current = end_pos
    until current.nil?
      path.unshift(current)
      current = @maze_cache[current]
    end
  end

  def get_moves(maze, from_pos)
    directions = [[0,1], [1,0], [-1,0], [0,-1]]
    x, y = from_pos
    result = []
    directions.each do |dx,dy|
      new_loc =[x + dx, y + dy]
      result << new_loc if is_valid_pos?(maze, new_loc)
    end

    result
  end

  

  def build_cache(start_pos)
    @maze_cache[start_pos] = nil
  end


end
