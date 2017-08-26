
map = [
  [0, 0, 1, -1, 1],
  [0, 0, 1, 0, 0],
  [0, 0, 1, 0, 0],
  [0, 1, 0, 0, 1],
  [0, 0, 0, 0, 0]
]

book = [
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0]
]

next_step = [
  [0, 1],
  [1, 0],
  [0, -1],
  [-1, 0]
]

struct = Struct.new(:x, :y, :step, :prev)
queue = []
flag = false

# begin
queue << struct.new(0, 0, 0, nil)
book[0][0] = 1

loop do
  break if queue.empty?

  next_step.each do |step|
    tx = queue.first.x + step[0]
    ty = queue.first.y + step[1]

    if tx >= map.first.size || ty < 0 ||
       ty >= map.size || tx < 0
      next
    end

    if map[tx][ty] == 0 && book[tx][ty] == 0
      book[tx][ty] = 1
      queue << struct.new(tx, ty, queue.first.step + 1, queue.first)
    end

    next unless map[tx][ty] == -1
    queue << struct.new(tx, ty, queue.first.step + 1, queue.first)
    flag = true
    break
  end
  break if flag
  queue.shift
end

# print result
if queue.empty?
  puts 'impossible!'
else
  node = queue.last
  puts "step : #{node.step}"
  stack = []
  loop do
    break if node.nil?
    stack << "#{node.x},#{node.y}"

    node = node.prev
  end

  puts stack.reverse.join '->'
end
