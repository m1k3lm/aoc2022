$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
require 'byebug'
class TestPuzzle < Test::Unit::TestCase
    def test_input
        d = Puzzle.new("input_test.txt")
        assert_equal 5, d.map.length
        assert_equal 8, d.map[0].length
        assert_equal [0,0], d.start
        assert_equal [2,5], d.end
    end
    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 31, d.solve_part1
    end
    def test_solve2
        d = Puzzle.new("input_test.txt")
        assert_equal 29, d.solve_part2
    end
end