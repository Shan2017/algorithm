
inf = 2**32
map = [
  [0, 1, 12, inf, inf, inf],
  [inf, 0, 9, 3 ,inf, inf],
  [inf, inf, 0, inf, 5, inf],
  [inf, inf, 4, 0, 13, 15],
  [inf, inf, inf, inf, 0, 4],
  [inf, inf, inf, inf, 0]
]

dis = map.first
book = []
dis.each_with_index { |item, index| book[index] = 0 }
u = 0

for i in 0...map.size - 1
  min = inf
  for j in 0...map.size
    if book[j].zero? && dis[j] < min
      min = dis[j]
      u = j
    end
  end
  book[u] = 1

  for v in 0...map.size
    dis[v] = dis[u] + map[u][v] if map[u][v] < inf && dis[v] > dis[u] + map[u][v]
  end
end

# print result
map.each do |item|
  item.each do |i|
    print i
    print ' '
  end
  print "\n"
  break
end