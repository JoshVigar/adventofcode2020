# frozen_string_literal: true

require_relative 'timer_helper.rb'
require_relative 'file_helper.rb'

STARTING_POSITION = [0, 0].freeze

class Toboggan
  def initialize
    @file = FileHelper.new('three-input.txt')
  end

  def go(across, down)
    tree_counter = 0
    @file.list.each do
      move(across, down)
      tree_counter += 1 if tree?
    end
    tree_counter
  end

  def current_position
    @current_position ||= STARTING_POSITION
  end

  def across(steps)
    @current_position = [current_position[0] + steps, current_position[1]]
  end

  def down(steps)
    @current_position = [current_position[0], current_position[1] + steps]
  end

  def move(across, down)
    across(across)
    down(down)
  end

  def tree?
    v_pos_line = @file.list[current_position[1]]
    return false if v_pos_line.nil?

    while current_position[0] >= v_pos_line.length
      current_position[0] -= v_pos_line.length
    end
    h_pos_char = v_pos_line[current_position[0]]
    h_pos_char == '#'
  end
end

p "Trees for across 1 down 1: #{one = Toboggan.new.go(1, 1)}"
p "Trees for across 3 down 1: #{two = Toboggan.new.go(3, 1)}"
p "Trees for across 5 down 1: #{three = Toboggan.new.go(5, 1)}"
p "Trees for across 7 down 1: #{four = Toboggan.new.go(7, 1)}"
p "Trees for across 1 down 2: #{five = Toboggan.new.go(1, 2)}"
p one * two * three * four * five
