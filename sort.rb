
def bubble_sort(nums, sort_by = :asc)
  last = nums.size - 1
  for i in 0...last
    for j in 0...last - i
      if sort_by == :asc
        nums[j], nums[j + 1] = nums[j + 1], nums[j] if nums[j] > nums[j + 1]
      else
        nums[j], nums[j + 1] = nums[j + 1], nums[j] if nums[j] < nums[j + 1]
      end
    end
  end
  nums
end

def quick_sort(nums)
  return nums if nums.size <= 1

  # 基准值是取第一个，所以j必须先移动
  x = nums.first

  i, j = 0, nums.size - 1
  loop do
    break if i == j

    # j must move first
    j -= 1 while i < j && nums[j] >= x
    i += 1 while i < j && nums[i] <= x

    nums[i], nums[j] = nums[j], nums[i]
  end
  left = nums[1..i]
  right = nums[(i + 1)...nums.size]

  result = []
  result += quick_sort(left)
  result += [x]
  result += quick_sort(right)
  result
end


p quick_sort [1,3,3,2,5,3,6,10,9,19,1,20]
p bubble_sort [1,3,3,2,5,3,6,10,9,19,1,20]