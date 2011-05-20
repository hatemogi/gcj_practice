def prob nums, on_calc = {}
  on_calc[nums.join(',')] = true
  unordered = []
  nums.each_with_index do |e, i|
    unordered << i + 1 unless e == (i + 1)
  end
  # p [:prob, nums, unordered]
  return 1.0 if unordered.size <= 2
  p = unordered.permutation.to_a
  # p([:perm, nums, unordered, p.size])
  r = p.inject(0.0) do |m, nord|
    nn = nums.dup
    # p([:nord, nums, nord])
    nord.each_with_index {|nv, ni| nn[ni] = nums[nv-1] }
    unless on_calc[nn.join(',')]
      v = prob(nn, on_calc) 
      p([:branch, nn, nord, v / p.size])
      m += (v / p.size)
    end
    m
  end
  r + (r / p.size)
end

def solve nums
  p [:solve, nums]
  prob nums
end

gets.to_i.times do |no|
  n = gets.to_i
  nums = gets.split.collect {|p| p.to_i} 
  puts "Case ##{no+1}: %.6f" % (1.0/solve(nums))
end