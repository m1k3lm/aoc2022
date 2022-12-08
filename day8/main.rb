$LOAD_PATH << '.'
require 'puzzle'
puzzle = Puzzle.new('input.txt')
puts "Part1 result is:", puzzle.solve_part1
puts "Part2 result is:", puzzle.solve_part2
