$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
require 'byebug'

class TestPuzzle < Test::Unit::TestCase
    def test_initialize
        d = Puzzle.new("input_test.txt")
        assert_equal 14, d.sensors.length
        assert_equal 20, d.sensors[13].position[0]
    end

    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 26, d.solve_part1(10)
    end

    def test_solve2
        d = Puzzle.new("input_test.txt")
        assert_equal 56000011, d.solve_part2(20)
    end
end