$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
require 'byebug'
class TestPuzzle < Test::Unit::TestCase
    def test_processor
        p = Processor.new([
            "noop",
            "addx 3",
            "addx -5",
        ])
        assert_equal [1,1,1,4,4,-1], p.x
    end
    def test_processor_2
        lines = File.open('input_test.txt', "r").readlines.map { |line| line.chomp }
        p = Processor.new(lines)
        assert_equal 21, p.x[20-1], "After 20th cycle"
        assert_equal 19, p.x[60-1], "After 60th cycle"
        assert_equal 18, p.x[100-1], "After 100th cycle"
        assert_equal 21, p.x[140-1], "After 140th cycle"
        assert_equal 16, p.x[180-1], "After 180th cycle"
        assert_equal 18, p.x[220-1], "After 220th cycle"
    end
    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 13140, d.solve_part1
    end
    def test_solve2
        d = Puzzle.new("input_test.txt")
        result = [
            "##..##..##..##..##..##..##..##..##..##..",
            "###...###...###...###...###...###...###.",
            "####....####....####....####....####....",
            "#####.....#####.....#####.....#####.....",
            "######......######......######......####",
            "#######.......#######.......#######.....",
        ]
        assert_equal result.join("\n"), d.solve_part2
    end
end