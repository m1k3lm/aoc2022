class Puzzle
    def initialize(filename)
        inputs = File.open(filename, "r").readlines.map { |line| line.chomp }

        n = (inputs[0].length+1)/4
        @stacks = Array.new(n){ [] }
        current_line = inputs.shift
        until current_line.start_with? " 1 "
          current_line.chars.each_slice(4).each_with_index do |slice,i|
            puts "Adding #{slice[1]} to stack #{i}"
            @stacks[i].unshift slice[1] unless slice[1] == " "
            puts "Stacks #{@stacks}"
          end 
          current_line = inputs.shift
        end
        inputs.shift
        @commands = []
        inputs.each do |input|
            @commands << Command.new(input)
        end
    end

    def solve_part1
      @commands.each do |c|
        puts "Move #{c.qty} from #{c.from} to stack #{c.to}"
        part = @stacks[c.from].pop(c.qty)
        c.qty.times do
          @stacks[c.to] << part.pop
        end
        puts "Stacks #{@stacks}"
      end
      ret = ""
      @stacks.each do |s|
        ret += s.last
      end
      ret
    end

    def solve_part2
      @commands.each do |c|
        puts "Move #{c.qty} from #{c.from} to stack #{c.to}"
        part = @stacks[c.from].pop(c.qty)
        c.qty.times do
          @stacks[c.to] << part.shift
        end
        puts "Stacks #{@stacks}"
      end
      ret = ""
      @stacks.each do |s|
        ret += s.last
      end
      ret
    end
end

class Command
  attr_accessor :qty, :from, :to
  def initialize(str)
    data = str.scan(/move ([\d]+) from ([\d]+) to ([\d]+)/i)[0]
    @qty = data[0].to_i
    @from = data[1].to_i-1
    @to  = data[2].to_i-1 
  end
end  