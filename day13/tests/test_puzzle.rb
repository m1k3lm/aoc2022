$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
require 'byebug'
class TestPuzzle < Test::Unit::TestCase
    def test_input
        d = Puzzle.new("input_test.txt")
        assert_equal 8, d.pairs.length
    end
    def test_compare_pairs
        d = Puzzle.new("input_test.txt")
        assert_equal -1, d.pairs[0][0].compare(d.pairs[0][1])
        assert_equal -1, d.pairs[1][0].compare(d.pairs[1][1])
        assert_equal 1, d.pairs[2][0].compare(d.pairs[2][1])
        assert_equal -1, d.pairs[3][0].compare(d.pairs[3][1])
        assert_equal 1, d.pairs[4][0].compare(d.pairs[4][1])
        assert_equal -1, d.pairs[5][0].compare(d.pairs[5][1])
        assert_equal 1, d.pairs[6][0].compare(d.pairs[6][1])
        assert_equal 1, d.pairs[7][0].compare(d.pairs[7][1])
    end
    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 13, d.solve_part1
    end
    def test_solve2
        d = Puzzle.new("input_test.txt")
        assert_equal 140, d.solve_part2
    end
end