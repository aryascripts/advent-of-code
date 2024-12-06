require 'set'
require_relative './day_runner'

class Day6 < DayRunner

  NEXT_DIRECTIONS = {
    move_up: :move_right,
    move_right: :move_down,
    move_down: :move_left,
    move_left: :move_up
  }.freeze

  def run(sample = false)
    @input = file_input(day: 6, sample: sample)

    @visited = Set.new
    @obstacles = Set.new
    @pos = nil
    @direction = :move_up


    @max_x = @input[0].length - 1
    @max_y = @input.length - 1

    @input.each_with_index do |line, i|
      line.split("").each_with_index do |char, j|
        @obstacles.add([j, i]) if char == "#"
        @pos = [j, i] if char != "#" && char != "."
      end
    end

    loop do
      outcome = self.send(@direction)
      break if outcome == "OUT_OF_BOUNDS"

      if outcome == "OBSTACLE"
        @direction = NEXT_DIRECTIONS[@direction] if outcome == "OBSTACLE"
      else
        @visited.add(@pos)
      end
    end

    p "Part 1: #{@visited.length}"
  end

  def move_up
    new_position = [@pos[0], @pos[1] - 1]
    return "OUT_OF_BOUNDS" if new_position[1] < 0
    return "OBSTACLE" if @obstacles.include?(new_position)
    @pos = new_position
  end

  def move_right
    new_position = [@pos[0] + 1, @pos[1]]
    return "OUT_OF_BOUNDS" if new_position[0] > @max_x
    return "OBSTACLE" if @obstacles.include?(new_position)
    @pos = new_position
  end

  def move_down
    new_position = [@pos[0], @pos[1] + 1]
    return "OUT_OF_BOUNDS" if new_position[1] > @max_y
    return "OBSTACLE" if @obstacles.include?(new_position)
    @pos = new_position
  end

  def move_left
    new_position = [@pos[0] - 1, @pos[1]]
    return "OUT_OF_BOUNDS" if new_position[0] < 0
    return "OBSTACLE" if @obstacles.include?(new_position)
    @pos = new_position
  end
end

Day6.new.run
