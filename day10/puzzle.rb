class Puzzle
    def initialize(filename)
        @lines = File.open(filename, "r").readlines.map { |line| line.chomp }
    end
    def solve_part1
        cpu = Processor.new(@lines)
        ret = 0
        [20, 60, 100, 140, 180, 220].each do |cycle|
            ret += cycle*cpu.x[cycle-1]
        end
        ret
    end
    def solve_part2
        width = 40
        height = 6
        crt = Crt.new(height,width)
        crt.cpu = Processor.new(@lines)
        crt.switch_on()
        puts "Part 2:\n\n"
        crt.pixels.map{ |row| row.join("") }.join("\n")
    end
end

class Processor
    attr_accessor :x
    def initialize(lines)
        @x=[1]
        step = 0
        lines.each do |line|
            commnad, argument = line.split(" ")
            exec_noop if commnad == "noop"
            exec_addx(argument.to_i) if commnad == "addx"
            step +=1
        end
    end
    def exec_noop
        @x<<@x.last
    end
    def exec_addx(arg)
        @x<<@x.last
        @x<<@x.last+arg
    end
end

class Crt
    attr_accessor :pixels, :cpu
    def initialize(height, width)
        @pixels = Array.new(height){
            Array.new(width,".")
        }
    end

    def lit(y,x)
        @pixels[y][x]="#"
    end

    def switch_on
        pixels.each_with_index do |row,y|
            row.each_with_index do |pixel,x|
                cycle = (y)*row.length+x
                sprite_center = cpu.x[cycle]
                lit y,x if sprite_center-1<=x && x<=sprite_center+1
            end
        end
    end
end