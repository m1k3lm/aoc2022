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
        @head = Node.new(0,0)
        @tail = Node.new(0,0)
        visited_positions = Set.new
        @moves.each do |move|
            direction , distance = move.split(" ")
            distance.to_i.times do
                @head.move(DIRECTIONS[direction])
                @tail.mov_towards(@head)
                visited_positions.add(@tail.position)
            end
        end
        return visited_positions.length
    end
end

class Node
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

    def mov_towards(node)
        dist_x = node.x-@x
        dist_y = node.y-@y
        if 1 < [dist_x.abs,dist_y.abs].max
            @x += dist_x/dist_x.abs if dist_x != 0
            @y += dist_y/dist_y.abs if dist_y != 0
        end
    end
end