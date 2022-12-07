class Puzzle
    def initialize(filename)
      @inputs = File.open(filename, "r").readlines.map{ |line| line.chomp }
      # Assume dir names are unique
      @fs = {"/" => Directory.new("/", nil)}
      @current = nil
      next_input
      while inputs_left?
        if @current_input.start_with?("$ cd")
          cd(@current_input[5..]) 
          next_input
        end
        if @current_input.start_with?("$ ls")
          next_input
          while @current_input && !@current_input.start_with?("$")
            if @current_input.start_with?("dir")
              dir = Directory.new(@current_input[4..], @current)
              @fs[dir.get_route] = dir
            else
              size, name = @current_input.split(" ")
              @current.add_file(name, size.to_i)
            end
            next_input
          end
        end
      end
    end

    def inputs_left?
      @inputs.length > 0
    end

    def next_input
      @current_input = @inputs.shift
      #puts "Processing: #{@current_input}"
    end

    def cd(dir)
      if dir == '/'
        @current = @fs['/']
      elsif dir == '..'
        @current = @fs[@current.parent.get_route]
      else
        @current = @fs[@current.get_route + "/#{dir}"]
      end
    end

    def print_fs (max, min=0)
      @fs.filter do |k, v|
        min <= v.size && v.size <= max
      end.each do |k, v|
        puts "#{k}: #{v.get_route} #{v.size}"
      end
      return nil
    end
    def solve_part1
      @fs.filter do |k, v|
        v.size <= 100000
      end.sum do |k, v|
        v.size
      end
    end
    def solve_part2
      unused_space = 70_000_000 - @fs['/'].size
      needed_space = 30_000_000 - unused_space
      elegibles = @fs.filter do |k, v|
        needed_space <= v.size 
      end
      elegibles.collect { |k, v| v.size }.min
    end
end


class Directory
  attr_accessor :name, :parent, :size, :files
  def initialize(name, parent)
    @name = name
    @parent = parent
    @size = 0
    @files = {}
  end
  def add_file(name, file_size)
    @files[name] = file_size
    increase_size(file_size)
  end
  def increase_size(file_size)
    @size += file_size
    parent.increase_size(file_size) unless parent.nil?
  end
  def get_route
    return "/" if parent.nil?
    return parent.get_route + "/" + name
  end
end