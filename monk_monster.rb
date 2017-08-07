# encoding: utf-8

# 妖怪与和尚过河问题

# 有三个和尚和三个妖怪要过河，这条小船一次只能载两个人。
# 同时，无论在河的两岸还是在船上，只要妖怪数量大于和尚的数量，妖怪就会吃掉和尚。、
# 怎样可以保证和尚和妖怪都能过河而且和尚不能被吃掉。

class ItemState
  attr_accessor :local_monster, :local_monk, :remote_monster,
                :remote_monk, :boat, :action

  def initialize(local_monster, local_monk, remote_monster,
                 remote_monk, boat, action)
    @local_monster = local_monster
    @local_monk = local_monk
    @remote_monster = remote_monster
    @remote_monk = remote_monk
    @boat = boat
    @action = action
  end

  def can_take_action?(action_effect)
    return false if @boat == action_effect[1]

    if (@local_monster + action_effect[2]) < 0 ||
       (@local_monster + action_effect[2]) > 3
      return false
    end

    if (@local_monk + action_effect[3]) < 0 ||
       (@local_monk + action_effect[3]) > 3
      return false
    end

    true
  end

  def take_action(action_effect, new_state)
    if can_take_action?(action_effect)
      new_state.local_monster = @local_monster + action_effect[2]
      new_state.local_monk = @local_monk + action_effect[3]
      new_state.remote_monster = @remote_monster - action_effect[2]
      new_state.remote_monk = @remote_monk - action_effect[3]
      new_state.boat = action_effect[1]
      new_state.action = action_effect[0]
      return true
    end
    false
  end

  def final_state?
    @remote_monk == 3 && @remote_monster == 3
  end

  def valid?
    ((@remote_monster <= @remote_monk) || @remote_monk.zero?) &&
      ((@local_monster <= @local_monk) || @local_monk.zero?)
  end
end

action_effects = [
  [:one_monster_go, :remote, -1, 0],
  [:two_monster_go, :remote, -2, 0],
  [:one_monk_go, :remote, 0, -1],
  [:two_monk_go, :remote, 0, -2],
  [:one_monster_one_monk_go, :remote, -1, -1],
  [:one_monster_back, :local, 1, 0],
  [:two_monster_back, :loacl, 2, 0],
  [:one_monk_back, :local, 0, 1],
  [:two_monk_back, :local, 0, 2],
  [:one_monster_one_monk_back, :local, 1, 1]
]

def print_result(state_list)
  state_list.each do |state|
    print state.action
    print ' -> '
  end
  puts
  puts '-' * 20
end

def state_processed?(state_list, new_state)
  state_list.each do |state|
    if state.local_monk == new_state.local_monk &&
       state.local_monster == new_state.local_monster &&
       state.remote_monk == new_state.remote_monk &&
       state.remote_monster == new_state.remote_monster &&
       state.boat == new_state.boat
      return true
    end
  end
  false
end

def search_state(state_list, action_effects)
  current_state = state_list.last

  if current_state.final_state?
    print_result(state_list)
    return
  end

  action_effects.each do |action_effect|
    new_state = current_state.dup
    next unless current_state.take_action(action_effect, new_state)

    next unless current_state.valid? && !state_processed?(state_list, new_state)

    state_list.push new_state
    search_state(state_list, action_effects)
    state_list.pop
  end
end

search_state([ItemState.new(3, 3, 0, 0, :local, :no_action)], action_effects)
