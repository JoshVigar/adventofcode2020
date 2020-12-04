# frozen_string_literal: true

require_relative 'timer_helper.rb'

def file
  File.open('one-input.txt')
end

def list
  @list ||= file.readlines.map(&:chomp)
end

def list_set
  @list_set ||= list.to_set
end

def search_fast
  list_set.each do |current_item|
    match = 2020 - current_item.to_i
    next unless list_set.include?(match.to_s)

    return current_item.to_i * match
  end
end

def search_three_items
  list_set.each do |item1|
    list_set.each do |item2|
      match = 2020 - (item1.to_i + item2.to_i)
      next unless list_set.include?(match.to_s)

      return item1.to_i * item2.to_i * match
    end
  end
end

def search_brute_force_slow
  list.each do |current_item|
    list.each do |loop_item|
      next unless (current_item.to_i + loop_item.to_i) == 2020

      return current_item.to_i * loop_item.to_i
    end
  end
end

list_set
delta { p search_brute_force_slow }
delta { p search_fast }
delta { p search_three_items }
