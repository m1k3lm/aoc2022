class Puzzle
    attr_accessor :bits, :packet
    def initialize(filename)
        @calories_by_elf = []
        calories_carry = 0
        File.open(filename, "r").readlines.map do |line|
            if line.chomp == ""
                @calories_by_elf << calories_carry
                calories_carry = 0
            else
                calories_carry += line.chomp.to_i
            end
        end
    end

    def solve_part1
        @calories_by_elf.max
    end

    def solve_part2
        @calories_by_elf.sort.last(3).sum()
    end 
end
