@map = [
	[0, 2, 6666],
	[2, 0, 3],
	[6, 3, 0]
]

@map2 = [
	[0, 2, 666],
	[2, 0, 3],
	[6, 3, 0]
]

def floyd
	for i in 0...@map.size
		for j in 0...@map.size
			for k in 0...@map.size
				@map[j][k] = @map[j][i] + @map[i][k]  if @map[j][k] > @map[j][i] + @map[i][k]
			end
		end
	end

	show_map @map
end

def dijkstra
	dis = @map2.first
	book = []
	dis.each_with_index { |item, index| book[index] = 0 }
	book[0]=1
	u = 0
	inf = 2**32
	# core code
	for i in 0...@map2.size - 1
	  min = inf
	  for j in 0...@map2.size
	    if book[j].zero? && dis[j] < min
	      min = dis[j]
	      u = j
	    end
	  end

	  book[u] = 1
	  for v in 0...@map2.size
	    dis[v] = dis[u] + @map2[u][v] if @map2[u][v] < inf && dis[v] > dis[u] + @map2[u][v]
	  end
	end

	show_map @map2
end

def show_map(map)
	map.each do |line|
		line.each do |item|
			print item
			print '\t'
		end
		puts
	end
end

floyd
puts
dijkstra