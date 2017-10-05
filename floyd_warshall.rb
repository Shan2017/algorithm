inf = 2**32
map = [
  [0, 2, 6, 4],
  [inf, 0, 3, inf],
  [7, inf, 0, 1],
  [5, inf, 12, 0]
]

for k in 0...map.size
  for i in 0...map.size
    for j in 0...map.size
      map[i][j] = map[i][k] + map[k][j] if map[i][j] > map[i][k] + map[k][j]
    end
  end
end

# print result
map.each do |item|
  item.each do |i|
    print i
    print ' '
  end
  print "\n"
end