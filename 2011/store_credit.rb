def solve credit, items
  head, *rest = items 
  if found = rest.find {|p| head[0] + p[0] == credit}
    return [head, found]
  end
  solve credit, rest
end

def eachset credit, items
  indexed = items.zip((1..items.length).to_a)
  cand = indexed.select {|p| p[0] < credit}.sort {|p| p[0]}.reverse 
  solve(credit, cand).collect(&:last).sort
end

gets.to_i.times do |no|
  c = gets.to_i
  i, items = gets.to_i, gets.split.collect(&:to_i)
  puts "Case ##{no+1}: #{eachset(c, items).join(' ')}"  
end
