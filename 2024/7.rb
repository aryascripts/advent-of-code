require_relative './day_runner'

class Day7 < DayRunner
  def run(sample: false)
    @input = file_input(day: 7, sample: sample)

    all_matched = []
    part2_matched = []
    unmatched_combinations = []

    @input.each do |line|
      result, numbers = line.split(':')
      numbers = numbers.split(" ").each(&:strip).map(&:to_i)
      result = result.to_i

      matched = process_combinations(result, numbers)

      all_matched << result if matched
      unmatched_combinations << [result, numbers] unless matched
    end

    unmatched_combinations.each do |unmatched|
      result, numbers = unmatched
      matched = process_combinations_2(result, numbers)

      part2_matched << result if matched
    end

    part_1_sum = all_matched.sum
    p "Part 1: #{part_1_sum}"
    p "Part 2: #{part_1_sum + part2_matched.sum}"
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

  def process_combinations_2(result, numbers)
    num_combinations = numbers.length - 2
    combinations = ['*', '+', '||'].product(*([['*', '+', '||' ]] * num_combinations))

    combinations.each do |combination|
      answer = numbers[0]
      numbers.each_with_index do |num, index|
        next if index == 0

        if combination[index - 1] == '||'
          answer = (answer.to_s + num.to_s).to_i
        else
          answer = answer.send(combination[index - 1], num)
        end
      end

      return true if  answer == result
    end

    false
  end
end

Day7.new.run
