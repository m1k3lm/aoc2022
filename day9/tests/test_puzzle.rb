$LOAD_PATH << '.'
require 'test/unit'
require 'puzzle'
require 'byebug'
class TestPuzzle < Test::Unit::TestCase
    def test_inital_position
        @head = Node.new(0,0)
        @tail = Node.new(0,0)
        assert_equal([0,0], @head.position)
        assert_equal([0,0], @tail.position)
    end

    def test_inital_R4
        @head = Node.new(0,0)
        @tail = Node.new(0,0)
        @head.move(Puzzle::DIRECTIONS["R"])
        assert_equal([1,0], @head.position)
        @tail.mov_towards(@head)
        assert_equal([0,0], @tail.position)

        @head.move(Puzzle::DIRECTIONS["R"])
        assert_equal([2,0], @head.position)
        @tail.mov_towards(@head)
        assert_equal([1,0], @tail.position)

        @head.move(Puzzle::DIRECTIONS["R"])
        assert_equal([3,0], @head.position)
        @tail.mov_towards(@head)
        assert_equal([2,0], @tail.position)

        @head.move(Puzzle::DIRECTIONS["R"])
        assert_equal([4,0], @head.position)
        @tail.mov_towards(@head)
        assert_equal([3,0], @tail.position)
    end
    
    def test_inital_U4
        @head = Node.new(4,0)
        @tail = Node.new(3,0)
        @head.move(Puzzle::DIRECTIONS["U"])
        assert_equal([4,1], @head.position)
        @tail.mov_towards(@head)
        assert_equal([3,0], @tail.position)

        @head.move(Puzzle::DIRECTIONS["U"])
        assert_equal([4,2], @head.position)
        byebug
        @tail.mov_towards(@head)
        assert_equal([4,1], @tail.position)

        @head.move(Puzzle::DIRECTIONS["U"])
        assert_equal([4,3], @head.position)
        @tail.mov_towards(@head)
        assert_equal([4,2], @tail.position)

        @head.move(Puzzle::DIRECTIONS["U"])
        assert_equal([4,4], @head.position)
        @tail.mov_towards(@head)
        assert_equal([4,3], @tail.position)
    end

    def test_solve1
        d = Puzzle.new("input_test.txt")
        assert_equal 13, d.solve_part1
    end
end