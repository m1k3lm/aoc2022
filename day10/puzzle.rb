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
    attr_accessor :pixels
    def initialize(v, h)
        @a = a
        @n = n
    end
    def solve
        @x = 0
        @n.each_with_index do |n, i|
            @x += @a[i]*m(i)*m(i).invmod(n)
        end
        @x % @n.reduce(:*)
    end
    def m(i)
        @n.reduce(:*) / @n[i]
    end
end

class Integer
    def invmod(n)
        x, lastx = 0, 1
        a, b = n, self
        while b != 0
            q = a / b
            a, b = b, a%b
            x, lastx = lastx - q*x, x
        end
        lastx % n
    end
end

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
        cpu = Processor.new(@lines)
        height.times do |y|
            width.times do |x|
                cycle = (y)*width+x
                sprite_center = cpu.x[cycle]
                crt.lit y,x if sprite_center-1<=x && x<=sprite_center+1
            end
        end
        puts "Part 2:\n\n"
        puts crt.pixels.map{ |row| row.join("") }.join("\n")
        crt.pixels
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
    attr_accessor :pixels
    def initialize(height, width)
        @pixels = Array.new(height){
            Array.new(width,".")
        }
    end
    def lit(y,x)
        @pixels[y][x]="#"
    end
end