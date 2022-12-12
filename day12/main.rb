$LOAD_PATH << '.'
require 'puzzle'
require 'byebug'
puzzle = Puzzle.new('input.txt')
puts "Part1 result is:", puzzle.solve_part1
puzzle = Puzzle.new('input.txt')
puts "Part2 result is:", puzzle.solve_part2
