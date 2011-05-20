List target_pos := method(color, origin, 
	self foreach(v, if(v at(0) == color, return v at(1)))
	origin
)

solve := method(seqs, o, b,
	if(seqs size == 0, return 0)
	to := seqs target_pos("O", o) 
	tb := seqs target_pos("B", b)
	job := seqs removeFirst
	dist_o := (to - o) abs
	dist_b := (tb - b) abs
	req_s := if(job at(0) == "O", dist_o + 1, dist_b + 1)
	dist_o = list(dist_o, req_s) min
	dist_b = list(dist_b, req_s) min
	no := if(to > o, o + dist_o, o - dist_o)
	nb := if(tb > b, b + dist_b, b - dist_b)
	req_s + solve(seqs, no, nb)
)

in := File standardInput
readnum := method(in readLine("") asNumber)
	
readnum repeat(no, 
	s := in readLine("") split
	n := s removeFirst asNumber
	seqs := list()
	n repeat(seqs append(list(s removeFirst, s removeFirst asNumber))) 
	("Case #" .. (no+1) .. ": " .. solve(seqs, 1, 1)) println
)
