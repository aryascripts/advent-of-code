require 'set'
require_relative './day_runner'

class Day6 < DayRunner

  NEXT_DIRECTIONS = {
    move_up: :move_right,
    move_right: :move_down,
    move_down: :move_left,
    move_left: :move_up
  }.freeze

  def run(sample = true)
    @input = file_input(day: 6, sample: sample)

    visited = Set.new
    obstacles = Set.new
    pos = nil
    direction = :move_up

    @max_x = @input[0].length - 1
    @max_y = @input.length - 1

    @input.each_with_index do |line, i|
      line.split("").each_with_index do |char, j|
        obstacles.add([j, i]) if char == "#"
        pos = [j, i] if char != "#" && char != "."
      end
    end

    loop do
      outcome = self.send(direction, pos, obstacles)
      break if outcome == "OUT_OF_BOUNDS"

      if outcome == "OBSTACLE"
        direction = NEXT_DIRECTIONS[direction]
      else
        pos = outcome
        visited.add(pos)
      end
    end

    p "Part 1: #{visited.length}"
  end

  def part_2(sample = true)
    @input = file_input(day: 6, sample: sample)

    obstacles = Set.new
    pos = nil

    @max_x = @input[0].length - 1
    @max_y = @input.length - 1

    @input.each_with_index do |line, i|
      line.split("").each_with_index do |char, j|
        obstacles.add([j, i]) if char == "#"
        pos = [j, i] if char != "#" && char != "."
      end
    end

    valid_obstacle_positions = Set.new

    # runs to make (where to place obstacles)
    (0..@max_x).each do |x|
      (0..@max_y).each do |y|
        # p "Running for #{x}, #{y}"
        tracker = Set.new
        temp_obstacle = [x, y]
        direction = :move_up

        next if temp_obstacle == pos

        current_run_pos = pos.dup

        loop do
          outcome = self.send(direction, current_run_pos, obstacles)
          if outcome == "OUT_OF_BOUNDS"
            # p "Breaking for out of bounds"
            break
          end

          if outcome == "OBSTACLE" || outcome == temp_obstacle
            direction = NEXT_DIRECTIONS[direction]
          else

            if tracker.include?("#{outcome.to_s}.#{direction}")
              valid_obstacle_positions.add(temp_obstacle)
              break
            end

            current_run_pos = outcome
            tracker << "#{current_run_pos.to_s}.#{direction}"
          end
        end
      end
    end
    p "Part 2: #{valid_obstacle_positions.length}"
  end

  def move_up(pos, obstacles)
    new_position = [pos[0], pos[1] - 1]
    return "OUT_OF_BOUNDS" if new_position[1] < 0
    return "OBSTACLE" if obstacles.include?(new_position)
    pos = new_position
  end

  def move_right(pos, obstacles)
    new_position = [pos[0] + 1, pos[1]]
    return "OUT_OF_BOUNDS" if new_position[0] > @max_x
    return "OBSTACLE" if obstacles.include?(new_position)
    pos = new_position
  end

  def move_down(pos, obstacles)
    new_position = [pos[0], pos[1] + 1]
    return "OUT_OF_BOUNDS" if new_position[1] > @max_y
    return "OBSTACLE" if obstacles.include?(new_position)
    pos = new_position
  end

  def move_left(pos, obstacles)
    new_position = [pos[0] - 1, pos[1]]
    return "OUT_OF_BOUNDS" if new_position[0] < 0
    return "OBSTACLE" if obstacles.include?(new_position)
    pos = new_position
  end
end

sample = false
day6 = Day6.new
day6.run(sample)
day6.part_2(sample)
