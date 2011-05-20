def solve values = []
  return 'NO' unless values.reduce(:^) == 0
  values.sort!
  values.shift
  values.reduce(:+)
end

gets.to_i.times do |no|
  n = gets.to_i
  pieces = gets.split.collect(:to_i)
  puts "Case ##{no+1}: #{solve(pieces)}"  
end