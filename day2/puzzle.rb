class Puzzle
    attr_accessor :bits, :packet
    def initialize(filename)
        @rounds = []
        File.open(filename, "r").readlines.map do |line|
            @rounds << line.chomp.split(" ")
        end
        byebug
    end

    def cal_outcome(elf, you)
        case elf
        when "A"
            case you
            when "X"
                return 3
            when "Y"
                return 6
            when "Z"
                return 0
            end
        when "B"
            case you
            when "X"
                return 0
            when "Y"
                return 3
            when "Z"
                return 6
            end
        when "C"
            case you
            when "X"
                return 6
            when "Y"
                return 0
            when "Z"
                return 3
            end
        end
    end

    def cal_shapevalue(elf, outcome)
        case elf
        when "A"
            case outcome
            when "X"
                return 3
            when "Y"
                return 1
            when "Z"
                return 2
            end
        when "B"
            case outcome
            when "X"
                return 1
            when "Y"
                return 2
            when "Z"
                return 3
            end
        when "C"
            case outcome
            when "X"
                return 2
            when "Y"
                return 3
            when "Z"
                return 1
            end
        end
    end

    def solve_part1
        score = 0
        @rounds.each do |r|
            case r[1]
            when "X"
                score += 1
            when "Y"
                score += 2
            when "Z"
                score += 3
            end
            score += cal_outcome r[0], r[1]
        end
        score
    end

    def solve_part2
        score = 0
        @rounds.each do |r|
            case r[1]
            when "X"
                score += 0
            when "Y"
                score += 3
            when "Z"
                score += 6
            end
            score += cal_shapevalue r[0], r[1]
        end
        score
    end
end
