$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
require 'byebug'
class TestPuzzle < Test::Unit::TestCase
    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 21, d.solve_part1
    end
    def test_solve2
        d = Puzzle.new("input_test.txt")
        assert_equal 1, d.visible_to_top(1,2)
        assert_equal 1, d.visible_to_left(1,2)
        assert_equal 2, d.visible_to_right(1,2)
        assert_equal 2, d.visible_to_bottom(1,2)
        assert_equal 4, d.scenic_score(1,2)
        assert_equal 8, d.scenic_score(3,2)
        assert_equal 8, d.solve_part2
    end
end