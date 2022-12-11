class Puzzle

    attr_accessor :monkeys

    def initialize(filename)
        @monkeys = []
        input = File.open(filename, "r").readlines.each_slice(7).map { |l0,l1,l2,l3,l4,l5,l6|
            id = l0.match(/^Monkey (\d+):$/)[1].to_i
            items = l1.match(/Starting items: (.*)$/)[1].split(',').map(&:to_i)
            operation = l2.match(/Operation: new = ([\w\+\*\d\s]+)/)[1].chomp
            divisible_by = l3.match(/Test: divisible by (\d+)$/)[1].to_i
            to_monkey_if_true = l4.match(/If true: throw to monkey (\d+)/)[1].to_i
            to_monkey_if_false = l5.match(/If false: throw to monkey (\d+)/)[1].to_i
            @monkeys[id] = Monkey.new(id, items, operation, divisible_by, to_monkey_if_true, to_monkey_if_false)
        }
        lcm = @monkeys.map(&:test_divisible_by).reduce(1, :lcm)
        @monkeys.each do |monkey|
            monkey.monkey_group_divisible_by_lcm = lcm
        end
    end

    def run_turn_for_monkey(monkey,with_relieving=true)
        monkey.play_turn(with_relieving).each do |to_monkey,item|
            @monkeys[to_monkey].items << item
        end
    end

    def run_round(with_relieving = true)
        @monkeys.each do |monkey|
            run_turn_for_monkey(monkey, with_relieving)
        end
    end

    def solve_part1
        20.times do
            run_round
        end
        @monkeys.map(&:inspected_items_count).sort.reverse[0..1].reduce(:*)
    end

    def solve_part2
        10000.times do
            run_round false
        end
        @monkeys.map(&:inspected_items_count).sort.reverse[0..1].reduce(:*)
    end
end

class Monkey
    attr_accessor :id,
        :items,
        :operation,
        :test_divisible_by,
        :to_monkey_if_true,
        :to_monkey_if_false,
        :inspected_items_count,
        :monkey_group_divisible_by_lcm
    def initialize(id,items,operation,test_divisible_by,to_monkey_if_true,to_monkey_if_false)
        @id = id
        @items = items
        @operation = operation
        @test_divisible_by = test_divisible_by
        @to_monkey_if_true = to_monkey_if_true
        @to_monkey_if_false = to_monkey_if_false
        @inspected_items_count = 0
    end
    def play_turn (with_relieving = true)
        items.dup.map do |item|
            @inspected_items_count += 1
            worry_level = apply_operation
            worry_level = (worry_level/3).floor if with_relieving
            worry_level = worry_level % monkey_group_divisible_by_lcm
            if((worry_level % test_divisible_by) == 0)
                [to_monkey_if_true, worry_level]
            else
                [to_monkey_if_false, worry_level]
            end
        end
    end

    def apply_operation
        eval(operation.gsub('old', items.shift.to_s))
    end
end
