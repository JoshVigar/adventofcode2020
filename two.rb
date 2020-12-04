# frozen_string_literal: true

require_relative 'timer_helper.rb'

def file
  File.open('two-input.txt')
end

def list
  @list ||= file.readlines.map(&:chomp)
end

def extract_policy(policy_string)
  split_policy_string = policy_string.split(' ')
  letter_occurence = split_policy_string[0].split('-')
  letter = split_policy_string[1]
  [letter_occurence, letter]
end

class TaskOne
  def valid?(policy_line, password)
    policy = extract_policy(policy_line)
    occurs = password.count(policy[1])
    return false if occurs < policy[0][0].to_i

    return false if occurs > policy[0][1].to_i

    true
  end

  def validate_passwords
    count = 0
    list.each do |entry|
      entry_arr = entry.split(':').map(&:strip)
      count += 1 if valid?(entry_arr[0], entry_arr[1])
    end
    count
  end
end

class TaskTwo
  def valid?(policy_line, password)
    policy = extract_policy(policy_line)
    letter = policy[1]
    position_one = policy[0][0].to_i - 1
    position_two = policy[0][1].to_i - 1
    if (password[position_one] == letter) ^ (password[position_two] == letter)
      return true
    end

    false
  end

  def validate_passwords
    count = 0
    list.each do |entry|
      entry_arr = entry.split(':').map(&:strip)
      count += 1 if valid?(entry_arr[0], entry_arr[1])
    end
    count
  end
end

puts "Total passwords: #{list.count}"
delta { puts "Valid passwords: #{TaskOne.new.validate_passwords}" }
delta { puts "Valid passwords: #{TaskTwo.new.validate_passwords}" }
