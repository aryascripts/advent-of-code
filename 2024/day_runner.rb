class DayRunner
  def file_input(day:, sample: false)
    suffix = sample ? "_sample" : "_input"
    input_file_contents = File.read("./inputs/#{day}#{suffix}.txt")
    input_file_contents.split("\n")
  end
end
