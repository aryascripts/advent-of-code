require_relative './day_runner'

class Day7 < DayRunner
  def part_1(sample: false)
    @input = file_input(day: 7, sample: sample)

    all_matched = []

    @input.each do |line|
      result, numbers = line.split(':')
      numbers = numbers.split(" ").each(&:strip).map(&:to_i)
      result = result.to_i

      all_matched << result if process_combinations(result.to_i, numbers)
    end

    p "Part 1: #{all_matched.sum}"
  end

  def process_combinations(result, numbers)
    num_combinations = numbers.length - 1
    combinations = ['*', '+'].product(*([['*', '+']] * num_combinations))

    combinations.each do |combination|
      answer = numbers[0]
      numbers.each_with_index do |num, index|
        next if index == 0

        answer = answer.send(combination[index - 1], num)
      end

      return true if  answer == result
    end
    false
  end

end

Day7.new.part_1
