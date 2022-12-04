class Puzzle

    def initialize(filename)
        @rucksacks = []
        File.open(filename, "r").readlines.map do |line|
            @rucksacks << Rucksack.new(line.chomp)
        end
    end

    def priority(item)
        ord = item.ord
        if ord>96
            return ord-96
        else
            return ord-38
        end
    end

    def solve_part1
        @rucksacks.sum { |r| priority r.missplace_item }
    end
    def solve_part2
        total_priority = 0
        @rucksacks.each_slice(3) do |r1, r2, r3|
            total_priority += priority r1.items.intersection(r2.items, r3.items)[0]
        end
        total_priority
    end
end

class Rucksack
    def initialize(str)
        @items = str.chars
        half = @items.length/2
        @compartments = []
        @compartments << @items.slice(0,half)
        @compartments << @items.slice(half,half)
    end

    def items
        @items
    end

    def missplace_item
        @compartments[0].intersection(@compartments[1])[0]
    end
end