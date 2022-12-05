class Puzzle

    def initialize(filename)
        @pairs = []
        File.open(filename, "r").readlines.map do |line|
            @pairs << line.chomp.split(",").map do |s|
                Section.new(*s.split("-"))
            end
        end
    end

    def solve_part1
        @pairs.count do |p|
            p[0].fully_contains?(p[1]) or p[1].fully_contains?(p[0])
        end
    end

    def solve_part2
        @pairs.count do |p|
            p[0].fully_contains?(p[1]) ||
            p[1].fully_contains?(p[0]) ||
            p[0].overlaps?(p[1]) ||
            p[1].overlaps?(p[0])
        end
    end
end

class Section
    attr_accessor :from, :to
    def initialize(from, to)
        @from = from.to_i
        @to = to.to_i
    end

    def fully_contains?(other)
        @from <= other.from && @to >= other.to
    end

    def overlaps?(other)
        (@from <= other.from && other.from <= @to) || 
        (@from <= other.to && other.to <= @to)
    end
end