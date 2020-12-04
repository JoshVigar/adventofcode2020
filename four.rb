# frozen_string_literal: true

require_relative 'timer_helper.rb'
require_relative 'file_helper.rb'

STARTING_POSITION = [0, 0].freeze

class BorderControl
  def initialize
    @file = FileHelper.new('four-input.txt')
  end

  def passports
    @file.list
  end
end

pp BorderControl.new.passports
