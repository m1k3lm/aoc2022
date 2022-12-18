require 'set'
class Puzzle
    attr_accessor :filled_spaces, :chain_at_step
    def initialize(filename)
        @filled_spaces = Set.new()
        inputs = File.open(filename, "r").readlines.map do |line| 
            segments = line.chomp.split(" -> ")
            segments.each_with_index do |segment,i|
                next if segments.length - 1 <= i 
                start_col,start_row = segment.split(",").map(&:to_i)
                end_col,end_row = segments[i+1].split(",").map(&:to_i)
                vertical_line([start_row,end_row],start_col)
                horizontal_line([start_col,end_col],start_row)
            end
        end
    end
    def vertical_line(from_to,col)
        (from_to.max + 1 - from_to.min).times{ |i| 
            @filled_spaces.add([col,from_to.min+i])
        }
    end
    def horizontal_line(from_to,row)
        (from_to.max + 1 - from_to.min).times{ |i| 
            @filled_spaces.add([from_to.min+i,row])
        }
    end
    
    def pour_grain(bottom,x,y)
        return false if bottom < y
        #puts "Pouring grain at #{x},#{y}"
        return pour_grain(bottom,x,y+1) unless @filled_spaces.include?([x,y+1])
        return pour_grain(bottom,x-1,y+1) unless @filled_spaces.include?([x-1,y+1])
        return pour_grain(bottom,x+1,y+1) unless @filled_spaces.include?([x+1,y+1])
        #puts "Fill space at #{x},#{y}"
        @filled_spaces.add([x,y])
        true
    end

    def pour_grain_2(bottom,x,y)
        #puts "Pouring grain at #{x},#{y}"
        @filled_spaces.add([x,y]) and return y if (bottom + 1) <= y
        return pour_grain_2(bottom,x,y+1) unless @filled_spaces.include?([x,y+1])
        return pour_grain_2(bottom,x-1,y+1) unless @filled_spaces.include?([x-1,y+1])
        return pour_grain_2(bottom,x+1,y+1) unless @filled_spaces.include?([x+1,y+1])
        #puts "Fill space at #{x},#{y}"
        @filled_spaces.add([x,y])
        y
    end

    def solve_part1
        bottom = filled_spaces.max_by(&:last)[1].dup.freeze
        grain_counter = 0
        while pour_grain(bottom,500,0) do
            grain_counter += 1
        end
        return grain_counter
    end

    def solve_part2
        bottom = filled_spaces.max_by(&:last)[1].dup.freeze
        grain_counter = 1
        started = false
        y = 0
        while 0 < pour_grain_2(bottom,500,y) do
            grain_counter += 1
        end
        return grain_counter
    end
end
