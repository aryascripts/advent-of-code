require_relative 'utils/array_sorter'

input_file_contents = File.read("1_input.txt")
lines = input_file_contents.split("\n")

array_1 = []
array_2 = []
lines.each do |line|
  splitted = line.split("   ")
  array_1.push splitted[0].to_i
  array_2.push splitted[1].to_i
end

sorted_array_1 = ArraySorter.new(array_1).sort
sorted_array_2 = ArraySorter.new(array_2).sort

array_2_tally = sorted_array_2.tally

difference = []
similarity_scores = []
for i in 0..array_1.length - 1
  # part 1
  diff = (sorted_array_1[i] - sorted_array_2[i]).abs
  difference.push(diff)

  # part 2
  element_1 = sorted_array_1[i]
  appears_count = array_2_tally[element_1] || 0
  similarity_scores.push(appears_count * element_1)
end

sum = difference.inject(0) { |sum, x| sum + x }
similarity = similarity_scores.inject(0) { |sum, x| sum + x }

p "sum = #{sum}; similarity = #{similarity}"
