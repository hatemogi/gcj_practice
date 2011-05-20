def goro_sort nums, unordered
  return 0 if unordered.empty?
  p [:gs, nums, unordered]
  p = unordered.first
  v = nums[p-1]
  t = nums[v-1]
  nums[p-1], nums[v-1] = t, v
  unordered.delete(v)
  unordered.delete(p) if nums[p-1] == p 
  2 + goro_sort(nums, unordered)
end

def solve nums
  unordered = []
  nums.each_with_index do |e, i|
    unordered << i + 1 unless e == (i + 1)
  end
  p [:solve, nums, unordered]
  goro_sort nums, unordered
end

gets.to_i.times do |no|
  n = gets.to_i
  nums = gets.split.collect {|p| p.to_i} 
  puts "Case ##{no+1}: %.6f" % solve(nums)
end