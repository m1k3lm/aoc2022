require 'set'
class Puzzle
    DIRECTIONS = {
        "R" => [1,0],
        "L" => [-1,0],
        "U" => [0,1],
        "D" => [0,-1]
    }

    def initialize(filename)
        @moves = File.open(filename, "r").readlines.map { |line| line.chomp }
    end

    def solve_part1
        head = Knot.new(0,0)
        tail = Knot.new(0,0)
        visited_positions = Set.new
        @moves.each do |move|
            direction , distance = move.split(" ")
            distance.to_i.times do
                head.move(DIRECTIONS[direction])
                tail.mov_towards(head)
                visited_positions.add(tail.position)
            end
        end
        return visited_positions.length
    end

    def solve_part2
        knots = Array.new(10) {
            Knot.new(0,0)
        }
        head = knots[0]
        tail = knots[9]
        visited_positions = Set.new
        @moves.each do |move|
            direction , distance = move.split(" ")
            distance.to_i.times do
                head.move(DIRECTIONS[direction])
                9.times do |i|
                    knots[i+1].mov_towards(knots[i])
                end
                visited_positions.add(tail.position)
            end
        end
        return visited_positions.length
    end
end

class Knot
    attr_accessor :x, :y
    def initialize(x,y)
        @x = x
        @y = y
    end

    def move(direction)
        @x += direction[0]
        @y += direction[1]
    end

    def position
        [@x,@y]
    end

    def mov_towards(knot)
        dist_x = knot.x-@x
        dist_y = knot.y-@y
        if 1 < [dist_x.abs,dist_y.abs].max
            @x += dist_x/dist_x.abs unless dist_x == 0
            @y += dist_y/dist_y.abs unless dist_y == 0
        end
    end
end