$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
require 'byebug'

class TestPuzzle < Test::Unit::TestCase
    def test_initialize
        d = Puzzle.new("input_test.txt")
        expected = Set.new()
        [
            [497,6],[496,6],
            [498,4],[498,5],[498,6],
            [503,4],[502,4],
            [502,5],[502,6],[502,7],[502,8],[502,9],
            [501,9],[500,9],[499,9],[498,9],[497,9],[496,9],[495,9],[494,9]
        ].each do |e|
            expected.add(e)
        end
        expected.each do |e|
            assert(d.filled_spaces.include?(e), "Expected #{e} to be in filled_spaces")
        end
        assert_equal expected.length , d.filled_spaces.length
        assert_equal expected.intersection(d.filled_spaces).length , expected.length
    end
    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 24, d.solve_part1
    end
    def test_solve2
        d = Puzzle.new("input_test.txt")
        assert_equal 93, d.solve_part2
    end
end