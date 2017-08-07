# encoding: utf-8

# 三个水桶等分8升水

# 有三个容积分别是3升、5升和8升的水桶，
# 8升的水桶装满了水，容积为3升和5升的水桶是空的。
# 三个水桶没有刻度，需要把8升的水分成两份，每份都是4升。
# 而且只能使用这三个水桶。

class Action
  attr_reader :from, :to, :water
  def initialize(from, to, water)
    @from = from
    @to = to
    @water = water
  end

  def to_s
    [@from, @to, @water].to_s
  end
end

class BucketState
  BUCKET_COPACITY = [3, 5, 8].freeze
  BUCKET_COUNT = BUCKET_COPACITY.size

  attr_accessor :action, :bucket_state
  def initialize(bucket_state = [0, 0, 8], action = Action.new(-1, 3, 8))
    @bucket_state = bucket_state
    @action = action
  end

  def can_take_dump_action?(from, to)
    return false unless from <= BUCKET_COUNT && from > 0
    return false unless to <= BUCKET_COUNT && to > 0

    return true if (from != to) && !empty?(from) && !full?(to)

    false
  end

  def dump_water(from, to, next_state)
    next_state.bucket_state = @bucket_state.dup
    dump_water = BUCKET_COPACITY[to - 1] - @bucket_state[to - 1]

    if next_state.bucket_state[from - 1] >= dump_water
      next_state.bucket_state[to - 1] += dump_water
      next_state.bucket_state[from - 1] -= dump_water
    else
      next_state.bucket_state[to - 1] += next_state.bucket_state[from - 1]
      dump_water = next_state.bucket_state[from - 1]
      next_state.bucket_state[from - 1] = 0
    end

    if dump_water > 0
      next_state.action = [from, to, dump_water]
      return true
    else
      return false
    end
  end

  def final_state?
    @bucket_state == [0, 4, 4]
  end

  def empty?(bucket)
    @bucket_state[bucket - 1] == 0
  end

  def full?(bucket)
    @bucket_state[bucket - 1] == BUCKET_COPACITY[bucket - 1]
  end
end

def state_processed?(bucket_state_list, new_state)
  bucket_state_list.each do |bucket_state|
    return true if bucket_state.bucket_state == new_state.bucket_state
  end

  false
end

def print_result(bucket_state_list)
  bucket_state_list.each do |bucket_state|
    print bucket_state.action
  end
  puts
  puts '-' * 20
end

def search_state(bucket_state_list)
  current_bucket_state = bucket_state_list.last

  if current_bucket_state.final_state?
    print_result(bucket_state_list)
    return
  end

  for i in 1..3
    for j in 1..3
      next unless current_bucket_state.can_take_dump_action?(j, i)
      next_state = BucketState.new
      if current_bucket_state.dump_water(j, i, next_state) &&
         !state_processed?(bucket_state_list, next_state)
        bucket_state_list.push next_state
        search_state(bucket_state_list)
        bucket_state_list.pop
      end
    end
  end
end

search_state [BucketState.new]
