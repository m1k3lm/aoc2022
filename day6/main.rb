$LOAD_PATH << '.'
require 'puzzle'
require 'byebug'

puzzle = Puzzle.new()
puts "Sample1  (7) result is:", puzzle.solve_part1("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
puts "Sample2  (5)  result is:", puzzle.solve_part1("bvwbjplbgvbhsrlpgdmjqwftvncz")
puts "Sample3  (6) result is:", puzzle.solve_part1("nppdvjthqldpwncqszvftbrmjlhg")
puts "Sample4  (10) result is:", puzzle.solve_part1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
puts "Sample5  (11)  result is:", puzzle.solve_part1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")

puts "Part1 result is:", puzzle.solve_part1(File.read("input.txt"))

puts "Sample1  (19) result is:", puzzle.solve_part2("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
puts "Sample2  (23)  result is:", puzzle.solve_part2("bvwbjplbgvbhsrlpgdmjqwftvncz")
puts "Sample3  (23) result is:", puzzle.solve_part2("nppdvjthqldpwncqszvftbrmjlhg")
puts "Sample4  (29) result is:", puzzle.solve_part2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
puts "Sample5  (26)  result is:", puzzle.solve_part2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")

puts "Part2 result is:", puzzle.solve_part2(File.read("input.txt"))