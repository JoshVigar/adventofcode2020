# frozen_string_literal: true

require_relative 'timer_helper.rb'
require_relative 'file_helper.rb'

require 'byebug'

class SeatFinder
  def initialize
    @file = FileHelper.new('five-input.txt')
  end

  def find_seat
    highest_id = 0
    @file.list.each do |input|
      row = b_search(row_list, input[0..6])
      seat = b_search(seat_list, input[7..9])
      id = (row[0]*8)+seat[0] 
      highest_id = id if id > highest_id
    end
    return highest_id
  end

  def find_your_seat
    @file.list.each do |input|
      row = b_search(row_list, input[0..6])
      seat = b_search(seat_list, input[7..9])
      list_fill (row[0]*8)+seat[0]
    end
    find_missing_id
  end

  def find_missing_id
    prev_id = id_list[0]
    id_list.each do |seat_id| 
      next if prev_id == seat_id
      if prev_id.to_i + 1 == seat_id
        prev_id = seat_id
        next
      else
        return seat_id - 1
      end
    end
  end

  def b_search(list, input)
    return list if list.length <= 1 
    return list if input.length < 1 
    if lower_half.include? input[0]
      return b_search(half(0, list), input[1..-1]) 
    else
      return b_search(half(1, list), input[1..-1])
    end
  end

  def list_fill(id)
    id_list << id if id_list.empty?
    id_pos = id_list.bsearch_index { |list_id| list_id >= id }
    id_pos == nil ? id_list << id : id_list.insert(id_pos, id)
  end

  def id_list
    @id_list ||= Array.new
  end

  def half(index, list)
    return list.each_slice(list.length/2).to_a[index]
  end

  def row_list
    (0..127).to_a
  end

  def seat_list
    (0..7).to_a
  end

  def lower_half
    %w[F L]
  end

  def upper_half
    %w[B R]
  end
end

sf = SeatFinder.new
p sf.find_your_seat
