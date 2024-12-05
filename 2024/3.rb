require_relative './day_runner'

class Day3 < DayRunner
  REGEX = /mul\(\d{1,3},\d{1,3}\)/

  def mul(a, b)
    a * b
  end

  def run(sample: false)
    @input = file_input(day: 3, sample: sample)

    all_matches = @input.reduce([]) do |acc, line|
      matches = line.scan(REGEX)
      matches.nil? ? acc : acc.concat(matches)
    end

    # THIS IS BAD. DON'T DO THIS IN ANYTHING PROD
    numbers = all_matches.map { |match| eval match }
    part_1 = numbers.inject(0) { |sum, x| sum + x }

    p "Part 1: #{part_1}"
  end
end

Day3.new.run
