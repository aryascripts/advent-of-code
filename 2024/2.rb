require_relative './day_runner'

class Day2 < DayRunner

  def run(sample: false)
    @input = file_input(day: 2, sample: sample)
    @input = @input.map { |line| line.split(" ").map(&:to_i) }

    safe_reports = @input.map { |report| safe?(report: report) }

    counts = safe_reports.tally
    part_1 = counts[true]


    safe_reports_with_dampen = @input.map do |report|
      safe?(report: report, dampen: true)
    end.tally

    part_2 = safe_reports_with_dampen[true]

    p "Part 1: #{part_1}; Part 2: #{part_2}"
  end

  def safe?(report:, dampen: false)
    safe = report_safe?(report: report)

    return safe unless dampen
    return true if safe && !dampen

    report.each_index do |i|
      dampened_report = report[0...i] + report[i+1..-1]
      return true if report_safe?(report: dampened_report)
    end

    false
  end

  def report_safe?(report:)
    type = (report[0] - report[1]) > 0 ? :decrease : :increase
    report.each_cons(2) do |c, n|
      return false if (c - n).abs > 3
      return false if c == n
      return false if (type == :decrease && c < n) || (type == :increase && c > n)
    end

    true
  end
end

Day2.new.run
