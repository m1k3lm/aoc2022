class Puzzle
  def initialize(filename)
      @trees = []
      inputs = File.open(filename, "r").readlines.map { |line|
        tree_row = []
        line.chomp.chars.each { |tree_height|
          tree_row << tree_height.to_i
        }
        @trees << tree_row
      }
  end

  def tree_column(col)
    @trees.map { |tree_row| tree_row[col] }
  end

  def is_edge_tree? (row, col)
    return true if row == 0 || row == @trees.length - 1
    return true if col == 0 || col == @trees[0].length - 1
    false
  end

  ## Part 1
  def solve_part1
    visble_trees = Array(0..@trees.length - 1).map { |row|
      Array(0..@trees[row].length - 1).map { |col| 0 }
    }
    @trees.each_with_index { |tree_row, row|
      tree_row.each_with_index { |tree, col|
        visble_trees[row][col] = 1 if is_edge_tree?(row, col) || is_visible?(row, col)
      }
    }
    #puts "-->\n#{visble_trees.map { |row| row.join('') }.join("\n")}"
    return visble_trees.sum{ |row| row.sum }
  end

  def is_visible?(row, col)
      highest_from_left(row, col) ||
      highest_from_right(row, col) ||
      highest_from_top(row, col) ||
      highest_from_bottom(row, col)
  end

  def highest_from_left(row, col)
    return @trees[row][col] > @trees[row].slice(0,col).max
  end

  def highest_from_right(row, col)
    return @trees[row][col] > @trees[row].slice(col + 1, @trees[row].length - col - 1 ).max
  end

  def highest_from_top(row, col)
    return @trees[row][col] > tree_column(col).slice(0,row).max
  end

  def highest_from_bottom(row, col)
    tree_col = tree_column(col)
    return @trees[row][col] > tree_col.slice(row+1,tree_col.length - row - 1).max
  end

  ## Part 2
  def solve_part2
    scenic_scores = Array(0..@trees.length - 1).map { |row|
      Array(0..@trees[row].length - 1).map { |col| 0 }
    }
    ret = @trees.each_with_index { |tree_row, row|
      tree_row.each_with_index { |tree, col|
        next if is_edge_tree?(row, col)
        scenic_scores[row][col] = scenic_score(row, col)
      }
    }
    #puts "-->\n#{scenic_scores.map { |row| row.map{|n| n.to_s.rjust(6, "0")}.join(' ') }.join("\n\n")}"
    return scenic_scores.map { |row| row.max }.max
  end

  def scenic_score(row,col)
    visible_to_left(row,col) *
    visible_to_right(row,col) *
    visible_to_top(row,col) *
    visible_to_bottom(row,col)
  end

  def visible_to_left(row,col)
    visible_trees = 1
    while 0 < col-visible_trees && @trees[row][col] > @trees[row].slice(col-visible_trees,visible_trees).max
      visible_trees += 1
    end
    return visible_trees
  end

  def visible_to_right(row,col)
    visible_trees = 1
    while col + visible_trees < @trees[row].length - 1 && @trees[row][col] > @trees[row].slice(col+1,visible_trees).max
      visible_trees += 1
    end
    return visible_trees
  end

  def visible_to_top(row,col)
    tree_col = tree_column(col)
    visible_trees = 1
    while  0 < row-visible_trees && @trees[row][col] > tree_col.slice(row-visible_trees,visible_trees).max
      visible_trees += 1
    end
    return visible_trees
  end

  def visible_to_bottom(row,col)
    tree_col = tree_column(col)
    visible_trees = 1
    while row+visible_trees < tree_col.length - 1 && @trees[row][col] > tree_col.slice(row+1,visible_trees).max
      visible_trees += 1
    end
    return visible_trees
  end
end
