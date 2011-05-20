# should be sorted before calling
def msp v1, v2
  return 0 if v1.empty? or v2.empty?
  if v1.first < v2.first or (v1.first == v2.first && v1.last <= v2.last)
    v1.shift * v2.pop
  else
    v1.pop * v2.shift
  end + msp(v1, v2)
end

gets.to_i.times do |no|
  gets.to_i
  v1, v2 = gets.split.collect(&:to_i), gets.split.collect(&:to_i)
  puts "Case ##{no+1}: #{msp(v1.sort, v2.sort)}"  
end
