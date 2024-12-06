require_relative './day_runner'

class Day5 < DayRunner
  def run(sample: false)
    @input = file_input(day: 5, sample: sample)
    rules, orders = @input.slice_before("").to_a
    rules.pop
    orders.shift

    @before_map = rule_map(rules)

    sum = 0

    rule_breaks = orders.map do |order|
      passed = []
      order = order.split(",").map { |num| num.to_i }

      broken = false

      order.each do |num|
        break if broken
        # get intersection of passed and before_map[num]
        # if the intersection is not empty, then we have a rule break
        if (passed & (@before_map[num] || [])).length > 0
          broken = true
          break;
        end

        passed << num
      end

      next if broken

      # get the middle number in order

      order[order.length / 2]
    end
    p rule_breaks.compact.inject(0) { |sum, x| sum + x }
  end

  def rule_map(rules)
    # key = number that we are on
    # value = the number that should come AFTER the key
    # e.g. 1 => [2] means that 1 should come before 2
    # if we are on the "key", then we should see if any of the numbers in it's value array have already been passed
    # if any of the numbers we have passed exist in the key's array, then we are breaking a rule.
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
