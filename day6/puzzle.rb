class Puzzle
  def find_maker(length)
    buffer = []
    datastream = @input.chars
    index = 0
    while buffer.length < length
      if buffer.include?(datastream[index])
        buffer.shift(buffer.index(datastream[index])+1)
      end
      buffer << datastream[index]
      index += 1
      puts "buffer: #{buffer} step: #{index} #{datastream[index]}"
    end
    index
  end

  def solve_part1(input)
    @input = input
    find_maker(4)
  end

  def solve_part2(input)
    @input = input
    find_maker(14)
  end

end