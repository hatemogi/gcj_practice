def combine elements, combines
  if (c = combines[elements.last(2).sort.join])
    elements = elements[0..-3] << c
  end
  elements
end

def clear_if_opposed elements, opposeds
  opposeds.select {|o| o.include? elements.last}.each do |o|
    return [] if (o - elements).empty?
  end
  elements
end

def invoke combines, opposeds, inputs, elements = []
  return elements if inputs.empty?
  e = inputs.shift
  elements << e
  if elements.size >= 2
    elements = combine(elements, combines) 
    elements = clear_if_opposed elements, opposeds
  end
  invoke(combines, opposeds, inputs, elements)
end

gets.to_i.times do |no|
  values = gets.split
  c = values.shift.to_i
  combines = values.take c
  combines = combines.inject({}) {|r, cb| r[[cb[0], cb[1]].sort.join] = cb[2]; r}
  values = values.drop(c)
  d = values.shift.to_i
  opposeds = values.take d
  opposeds = opposeds.collect {|o| [o[0], o[1]]}
  values = values.drop(d)
  n = values.shift.to_i
  elements = values.first.each_char.to_a
  puts "Case ##{no+1}: [#{invoke(combines, opposeds, elements).join(', ')}]"  
end