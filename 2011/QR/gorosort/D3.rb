#!/usr/bin/ruby

T = gets.to_i
T.times do |case_num|
	n = gets.to_i
	a = gets.split.map(&:to_i)
	b = a.sort
	res = 0
	0.upto(a.size - 1) do |i|
		res += 1 if a[i] != b[i]
	end
	printf "Case #%d: %.6f\n", case_num + 1, res
end
