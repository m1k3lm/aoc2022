require 'Set'
require 'pry'

class Puzzle
    attr_accessor :sensors
    def initialize(filename)
        @sensors = []
        File.open(filename, "r").readlines.each { |line|
            positions = line.chomp.match(/Sensor at x=([\-\d]+), y=([\-\d]+): closest beacon is at x=([\-\d]+), y=([\-\d]+)/)
            @sensors << Sensor.new(
                [positions[1].to_i,positions[2].to_i],
                [positions[3].to_i,positions[4].to_i],
            )
        }
    end

    def beacons_at_row(row_num)
        sensors.each.filter do |s|
            s.nearest_beacon[1] == row_num
        end.map(&:nearest_beacon).uniq.count
    end

    def solve_part1(row_num)
        ocupied_positions = Set.new()
        sensors.each do |s|
            range = s.distance_to_beacon - s.distance_to_row(row_num)
            next if range < 1
            from = s.position[0] - range
            to = s.position[0] + range
            (from..to).each do |x|
                ocupied_positions.add([x,row_num])
            end
        end
        ocupied_positions.count - beacons_at_row(row_num)
    end

    def solve_part2(max)
        sensors.sort_by! { |s| s.position[0] }
        max.times do |y|
            x=0
            sensors.each do |s|
                next unless s.is_in_range?([x,y])
                x = s.range_in_row(y) + 1
            end
            return 4000000*x + y if x <= max
        end
    end
end

class Sensor
    attr_accessor :position,:nearest_beacon
    def initialize(position,nearest_beacon)
        @position = position
        @nearest_beacon = nearest_beacon
    end

    def distance_to_beacon
        @distance_to_beacon ||= distance_to(nearest_beacon)
    end

    def distance_to_row(row)
        (position[1]-row).abs
    end

    def distance_to(point)
        (point[0]-position[0]).abs + (point[1]-position[1]).abs  
    end

    def is_in_range?(point)
        distance_to(point) <= distance_to_beacon
    end

    def range_in_row(row)
        position[0] + distance_to_beacon - distance_to_row(row)
    end
end