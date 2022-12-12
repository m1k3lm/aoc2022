require 'set'
class Puzzle
    attr_accessor :map, :start, :end
    def initialize(filename)
        @original_map  = Array.new()
        inputs = File.open(filename, "r").readlines.map { |line| 
            @original_map << line.chomp.chars
            @original_map.last.each_with_index do |c,i|
                @start = [@original_map.length-1, i] if c == 'S'
                @end = [@original_map.length-1, i] if c == 'E'
            end
        }
        @original_map[@start[0]][@start[1]] = "a"
        @original_map.freeze
        set_map
    end

    def set_map
        @map = Marshal.load( Marshal.dump(@original_map))
    end

    def find_shotest_path(from)
        set_map
        @possible_paths=[[from]]
        step = 0
        while !@possible_paths[0].nil? && @possible_paths[0].last != @end
            find_next_possible_paths()
            # puts step
            # @possible_paths.each do |path|
            #      puts "-> #{path.inspect}"
            # end
            # step += 1
        end
        #print_path(@possible_paths[0])
        return 9999 if @possible_paths[0].nil?
        @possible_paths[0].length - 1 
    end
    
    def find_next_possible_paths()
        paths_to_test = @possible_paths.dup
        @possible_paths = []
        paths_to_test.each do |path|
            path.freeze
            threshold = @map[path.last[0]][path.last[1]].ord + 1
            neighbours(path).each do |neighbour|
                new_path = path.dup
                if "z".ord <= threshold && is_end?(neighbour)
                    new_path << neighbour
                    @possible_paths = [new_path]
                    return
                end
                if !is_visited?(neighbour) && @map[neighbour[0]][neighbour[1]].ord <= threshold && !is_end?(neighbour)
                    new_path << neighbour
                    @possible_paths << new_path
                    @map[path.last[0]][path.last[1]] = "#"
                end
            end
        end
    end

    def is_end?(point)
        @map[point[0]][point[1]] == 'E'
    end

    def is_visited?(point)
        @map[point[0]][point[1]] == "#"
    end
    
    def neighbours(path)
        ret = []
        ret << [path.last[0]-1,path.last[1]] if 0 <= path.last[0]-1
        ret << [path.last[0],path.last[1]-1] if 0 <= path.last[1]-1
        ret << [path.last[0]+1,path.last[1]] if path.last[0]+1 < @map.length
        ret << [path.last[0],path.last[1]+1] if path.last[1]+1 < @map[0].length
        ret
    end

    def get_direction(path,n)
        return "E" if path.length-1 <= n
        return "v" if path[n][0] < path[n+1][0]
        return "^" if path[n][0] > path[n+1][0]
        return ">" if path[n][1] < path[n+1][1]
        return "<" if path[n][1] > path[n+1][1]    
    end

    def print_path(path)
        canvas = Array.new(@map.length) { Array.new(@map[0].length) { "." } }
        path.each_with_index do |p,i|
            canvas[p[0]][p[1]] = get_direction(path,i)
        end
        puts canvas.map { |line| line.join("") }.join("\n")
    end

    def solve_part1
        find_shotest_path(@start)
    end

    def solve_part2
        paths = []
        @original_map.each_with_index do |row,y|
            row.each_with_index do |col,x|
                puts "Starting at #{x},#{y} col=#{col}"
                paths << find_shotest_path([y,x]) if col == "a"
            end
        end
        byebug

        paths.min
    end
end