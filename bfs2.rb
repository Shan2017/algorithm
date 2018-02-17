
def bfs(que, book, map, n, m, p, q)
	head, tail = 1, 2
	flag = 0
	next_step = [
						[0, 1],
						[1, 0],
						[0, -1],
						[-1, 0]
	]

	while head < tail
		for i in 0...4
			tx = que[head].x + next_step[i].first
			ty = que[head].y + next_step[i].last

			next if tx < 1 || tx > n || ty < 1 || ty > m

			if book[tx][ty] == 0 && map[tx][ty] == 0
				book[tx][ty] = 1

				node = @node.new
				node.x = tx
				node.y = ty
				node.upper = head
				node.step = que[head].step + 1

				que[tail] = node
				tail += 1
			end

			if tx == p && ty == q
				flag = 1
				break
			end
		end # for

		break if flag == 1

		head += 1
	end # while
	puts que[tail - 1].step
	puts que[tail - 1].to_s
end

@node = Struct.new(:x, :y, :upper, :step)
que = Array.new(25)
book = Array.new(51, [])
map = Array.new(51, [])

book = [
		[0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0]
]
puts "input n"
n = 5#gets.chomp.to_i
puts "input m"
m = 4#gets.chomp.to_i

# puts "input map"
# n.times do |i|
# 	m.times do |j|
# 		map[i + 1][j + 1] = gets.chomp.to_i
# 	end
# end

map = [
		[0, 0, 0, 0, 0],
		[0, 0, 0, 1, 0],
		[0, 0, 0, 0, 1],
		[0, 0, 0, 1, 0],
		[0, 0, 1, 0, 0],
		[0, 0, 0, 0, 1]
]

puts "input start x"
start_x = 1#gets.chomp.to_i
puts "input start y"
start_y = 1#gets.chomp.to_i
puts "input p"
p = 3#gets.chomp.to_i
puts "input q"
q = 4#gets.chomp.to_i

node = @node.new
node.x = start_x
node.y = start_y
node.upper = 0
node.step = 0
que[1] = node

book[start_x][start_y] = 1

bfs(que, book, map, n, m, p, q)