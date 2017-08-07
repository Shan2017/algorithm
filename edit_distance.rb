# encoding: utf-8

# 字符串的编辑距离

# 将一个字符串转换成另外一个字符串时需要付出的代价。
# 转换可以采用插入、删除和替换三种编辑方式，因此转换的代价就是对字符串的编辑次数

def edit_distance(src, dest)
  return (src.length - dest.length).abs if src.empty? || dest.empty?

  return edit_distance(src[1..src.length], dest[1..dest.length]) if src[0] == dest[0]

  ins = edit_distance(src, dest[1..src.length]) + 1
  del = edit_distance(src[1..src.length], dest) + 1
  rep = edit_distance(src[1..src.length], dest[1..dest.length]) + 1
  [ins, del, rep].min
end
