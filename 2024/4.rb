require_relative './day_runner'

class Day4 < DayRunner
  def run(sample: false)
    @input = file_input(day: 4, sample: sample)
    grid = @input.map { |line| line.split("") }

    @vertical_index = grid.length - 1
    @horizontal_index = grid[0].length - 1

    count = count_xmas(grid)
    p "Part 1: #{count}"
  end

  # counts the words XMAS in the grid
  # in all directions (up, down, left, right, diagonal) and backwards
  def count_xmas(grid)
    count = 0
    grid.each_with_index do |line, i|
      line.each_with_index do |char, j|
        if (char == "X")
          # if i == 5 && j == 6
          right = grid[i][j..j+3].join
          left = grid[i][j-3..j].join.reverse
          up = grid[i-3..i].map { |line| line[j] }.join.reverse
          down = grid[i..i+3].map { |line| line[j] }.join

          diagonal_down_right = (0..3).map { |k| grid[i+k][j+k] }.join if valid_diagonal_down?(i, j) && valid_diagonal_right?(i, j)
          diagonal_up_right = (0..3).map { |k| grid[i-k][j+k] }.join if valid_diagonal_up?(i, j) && valid_diagonal_right?(i, j)
          diagonal_down_left = (0..3).map { |k| grid[i+k][j-k] }.join if valid_diagonal_down?(i, j) && valid_diagonal_left?(i, j)
          diagonal_up_left = (0..3).map { |k| grid[i-k][j-k] }.join if valid_diagonal_up?(i, j) && valid_diagonal_left?(i, j)

          tallied = [right, left, up, down, diagonal_down_right, diagonal_up_right, diagonal_down_left, diagonal_up_left].tally
          if tallied["XMAS"].to_i > 0
            count += tallied["XMAS"]
          end
        end
      end
    end
    count
  end

  def valid_diagonal_up?(i, j)
    i >= 3
  end

  def valid_diagonal_down?(i, j)
    i <= @vertical_index - 3
  end

  def valid_diagonal_left?(i, j)
    j >= 3
  end

  def valid_diagonal_right?(i, j)
    j <= @horizontal_index - 3
  end
end

Day4.new.run
