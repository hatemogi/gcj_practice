def _solve credit, items
  head, *rest = items 
  if found = rest.reverse.find {|p| head[0] + p[0] == credit}
    [head, found]
  else
    raise "no solution for #{{:credit => credit, :items => items}}" if rest.count < 2
    _solve credit, rest
  end   
end

def solve credit, items
  indexed = items.zip (1..items.length).to_a
  cand = indexed.select {|p| p[0] < credit}.sort {|p| p[0]}.reverse 
  values = _solve(credit, cand)
  values.collect(&:last).sort
end

N = gets.to_i
no = 0

while (c = gets) do 
  c = c.to_i
  i, items = gets.to_i, gets.split.collect(&:to_i)
  puts "Case ##{no += 1}: #{solve(c, items).join(' ')}"  
end
