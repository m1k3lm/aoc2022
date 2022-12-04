$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
class TestPuzzle < Test::Unit::TestCase
    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 150, d.solve_part1
    end
    def test_solve2
        d = Puzzle.new("input_test.txt")
        assert_equal 900, d.solve_part2
    end
end