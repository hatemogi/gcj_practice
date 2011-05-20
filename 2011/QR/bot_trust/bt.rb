def target_pos color, seqs
  v = seqs.assoc(color)
  v && v[1]
end

def solve seqs, o = 1, b = 1
  return 0 if seqs.empty?
  to = target_pos("O", seqs) || o
  tb = target_pos("B", seqs) || b
  job = seqs.shift
  dist_o = (to - o).abs
  dist_b = (tb - b).abs
  req_s = (job[0] == "O") ? dist_o + 1 : dist_b + 1
  dist_o = [dist_o, req_s].min
  dist_b = [dist_b, req_s].min
  no = (to > o) ? o + dist_o : o - dist_o
  nb = (tb > b) ? b + dist_b : b - dist_b
  req_s + solve(seqs, no, nb)
end

gets.to_i.times do |no|
  s = gets.split
  n = s.shift.to_i
  seqs = []
  n.to_i.times { seqs << [s.shift, s.shift.to_i] }
  puts "Case ##{no+1}: #{solve seqs}"  
end