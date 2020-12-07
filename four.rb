# frozen_string_literal: true

require_relative 'timer_helper.rb'
require_relative 'file_helper.rb'

require 'byebug'

STARTING_POSITION = [0, 0].freeze

class BorderControl
  def initialize
    @file = FileHelper.new('four-input.txt')
  end

  def check_all
    valid_count = 0
    passports.each do |passport|
      valid_count += 1 if check_single(passport)
    end
    valid_count
  end

  def check_single(passport)
    required.each { |field| return false unless passport.include?(field) }
    hash = passport_hash(passport)
    return false unless check_year(hash['byr'], 1920, 2002)
    return false unless check_year(hash['iyr'], 2010, 2020)
    return false unless check_year(hash['eyr'], 2020, 2030)
    return false unless check_height(hash['hgt'])
    return false unless hash['hcl'] =~ hair_colour_regex
    return false unless eye_colours.include?(hash['ecl'])
    p hash['pid']
    return false unless "013861920".length == 9
    true
  end

  def passports
    @passports ||= @file.split("\n\n").map do |passport|
      passport.gsub("\n", ' ')
    end
  end

  def passport_hash(passport)
    Hash[passport.split(' ').map { |field| field.split(':') }]
  end
  
  def check_year(year, min, max)
    return false if year.length != 4
    return false if year.to_i < min
    return false if year.to_i > max
    true
  end

  def excluded
    %w[cid]
  end

  def required
    %w[byr iyr eyr hgt hcl ecl pid]
  end

  def eye_colours
    %w[amb blu brn gry grn hzl oth]
  end

  def hair_colour_regex
    /^#([a-f]|[0-9])\w{5}$/
  end

  def check_height(height)
    if height.include?('cm')
      return false if height.to_i < 150
      return false if height.to_i > 193
      return true
    elsif height.include?('in')
      return false if height.to_i < 59
      return false if height.to_i < 76
      return true
    end
    false
  end
end

puts BorderControl.new.check_all
