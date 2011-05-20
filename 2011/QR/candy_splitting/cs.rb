class Fixnum
  def patrick_sum b
    (self | b) & ~(self & b)
  end
end

def solve seans, patricks = [], answers = {}, best = 0
  key = seans.join(':')
  return answers[key] if answers[key]
  seans_v = seans.reduce(:+) || 0
  patricks_v = patricks.reduce(:+) || 0
  answers[key] = best
  return best if seans_v <= best || seans.size() == 1 #|| patricks_v > seans_v || seans.size() == 1
  if patricks.size() > 0 && seans.reduce(:patrick_sum) == patricks.reduce(:patrick_sum)
    return answers[key] = seans_v
  end

  seans.each_index do |si|
    s = seans.dup
    e = s.delete_at(si)
    best = [solve(s, patricks << e, answers, best), best].max
  end
  best 
end

gets.to_i.times do |no|
  n = gets.to_i
  pieces = gets.split.collect {|p| p.to_i} 
  r = solve(pieces)
  puts "Case ##{no+1}: #{(r == 0) ? 'NO' : r}"  
end