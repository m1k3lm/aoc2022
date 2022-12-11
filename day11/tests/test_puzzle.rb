$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
require 'byebug'
class TestPuzzle < Test::Unit::TestCase

    def test_monkeyloading
        d = Puzzle.new("input_test.txt")
        assert_equal 4, d.monkeys.size
    end

    def test_monkey0_1_turn
        d = Puzzle.new("input_test.txt")
        assert_equal [[3,500],[3,620]], d.monkeys[0].play_turn()
    end

    def test_monkeys_round_1
        d = Puzzle.new("input_test.txt")
        expecteds = [
            [[3,500],[3,620]],
            [[0,20],[0,23],[0,27],[0,26]],
            [[1,2080],[3,1200],[3,3136]],
            [[1,25],[1,167],[1,207],[1,401],[1,1046]],
    
        ]
        expecteds.each_with_index do |expected,i|
            assert_equal expected, d.monkeys[i].play_turn()
            expected.each do |to_monkey,item|
                d.monkeys[to_monkey].items << item
            end
        end
        expecteds.each_with_index do |expected,i|
            assert_equal expected.length, d.monkeys[i].inspected_items_count
        end
    end

    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 10605, d.solve_part1
    end

    def test_solve2
        d = Puzzle.new("input_test.txt")
        ret = d.solve_part2
        assert_equal 52166, d.monkeys[0].inspected_items_count
        assert_equal 47830, d.monkeys[1].inspected_items_count
        assert_equal 1938, d.monkeys[2].inspected_items_count
        assert_equal 52013, d.monkeys[3].inspected_items_count
        assert_equal 2713310158, ret
    end
end