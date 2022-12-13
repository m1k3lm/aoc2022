class Puzzle
    attr_accessor :pairs
    def initialize(filename)
        @packets = []
        inputs = File.open(filename, "r").readlines.each_slice(3).map { |l1,l2|
            @packets << Packet.new(l1.chomp)
            @packets << Packet.new(l2.chomp)
        }
        @pairs = @packets.each_slice(2).to_a
    end

    def solve_part1
        ret = 0
        @pairs.each_with_index do |pair,i|
            puts "pair #{i} is #{pair[0].compare(pair[1])} !"
            ret += (i+1) if pair[0].compare(pair[1]) < 0
        end
        ret
    end

    def solve_part2
        @packets<<Packet.new("[[2]]")
        @packets<<Packet.new("[[6]]")
        @packets.sort! { |a,b| a.compare(b) }
        b=0
        a=0
        @packets.each_with_index do |p,i|
            a = (i+1) if p.to_s == "[[2]]"
            b = (i+1) if p.to_s == "[[6]]"
            puts p.to_s
        end
        a*b
    end
end

class Packet
    attr_accessor :content
    def initialize(content)
        @content = eval(content)
    end
    def compare(other_packet)
        content.each_with_index do |current, i|
            result = 0
            return 1 if other_packet.content[i].nil?
            if current.is_a?(Integer) and other_packet.content[i].is_a?(Integer) 
                return 1 if other_packet.content[i] < current
                return -1 if other_packet.content[i] > current
            else
                if current.is_a?(Array) and other_packet.content[i].is_a?(Array)
                    result = Packet.new(current.to_s).compare(Packet.new(other_packet.content[i].to_s))
                end
                if current.is_a?(Integer) and other_packet.content[i].is_a?(Array)
                    result = Packet.new("[#{current}]").compare(Packet.new(other_packet.content[i].to_s))
                end
                if current.is_a?(Array) and other_packet.content[i].is_a?(Integer)
                    result = Packet.new(current.to_s).compare(Packet.new("[#{other_packet.content[i]}]"))
                end
            end
            return result unless result==0 
        end
        return -1 if content.length < other_packet.content.length
        return 0
    end
    def to_s
        content.to_s
    end
end