# encoding: utf-8

# Google方程式

# WWWDOT - GOOGLE = DOTCOM是一个由字符组成的等式，每个字符代表0～9之间的数字。
# WWWDOT、GOOGLE和DOTCOM都是合法数字，不能以0开头。
# 找出能够满足等式的字符方程式

char_items = [
  # [字母本身, 字母代表的数字, 是否是最高位]
  ['w', -1, true], ['d', -1, true], ['o', -1, false],
  ['t', -1, false], ['g', -1, true], ['l', -1, false],
  ['e', -1, false], ['c', -1, false], ['m', -1, false]
]

char_values = [
  # [数字， 是否被占用]
  [0, false], [1, false], [2, false], [3, false], [4, false],
  [5, false], [6, false], [7, false], [8, false], [9, false]
]

def valid?(item, value)
  is_leading = item[2]
  return false if is_leading && value[0].zero?
  true
end

def make_interger_value(items, str)
  result = []
  str.each_char do |char|
    items.each do |item|
      result << item[1] if item[0] == char
    end
  end
  result.join.to_i
end

def char_list_ready(char_items)
  minuend = 'wwwdot'
  substrahend = 'google'
  diff = 'dotcom'

  m = make_interger_value(char_items, minuend)
  s = make_interger_value(char_items, substrahend)
  d = make_interger_value(char_items, diff)

  puts "#{m} - #{s} = #{d}" if (m - s) == d
end

def searching_result(char_items, char_values, index)
  return char_list_ready(char_items) if index == 9

  char_values.each do |value|
    next unless valid?(char_items[index], value)
    next if value[1]
    value[1] = true
    char_items[index][1] = value[0]
    searching_result(char_items, char_values, index + 1)
    value[1] = false
  end
end

searching_result(char_items, char_values, 0)
