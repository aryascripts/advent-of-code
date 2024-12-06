require_relative './day_runner'

class Day5 < DayRunner
  def run(sample: false)
    @input = file_input(day: 5, sample: sample)
    rules, orders = @input.slice_before("").to_a
    rules.pop; orders.shift

    rule_map = rule_map(rules)
    rule_breaks = orders.map do |order|
      passed = []
      order = order.split(",").map { |num| num.to_i }

      broken = false

      order.each do |num|
        break if broken
        if (passed & (rule_map[num] || [])).length > 0 # intersection = broken rules
          broken = true
          break;
        end

        passed << num
      end

      next if broken
      order[order.length / 2]
    end
    p "Part 1: #{rule_breaks.compact.inject(0) { |sum, x| sum + x }}"
  end

  def rule_map(rules)
    # key = number that we are on
    # value = the number that should come AFTER the key
    before_map = {}

    rules.each do |rule|
      r = rule.split("|").map { |num| num.strip.to_i }
      before_map[r[0]] = [] if before_map[r[0]].nil?
      before_map[r[0]] << r[1]
    end

    before_map
  end
end

Day5.new.run
