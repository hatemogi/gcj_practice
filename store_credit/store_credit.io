solve := method(credit, items,
	head := items removeFirst
	items foreach(i, v, 
		(head at(0) + v at(0) == credit) ifTrue(return list(head, v)))
	solve(credit, items)
)

in := File standardInput
readnum := method(in readLine("") asNumber)

readnum repeat(n, 
	credit := readnum
	count := readnum
	values := in readLine("") split map(i, v, list(v asNumber, i + 1)) 
	cand := values select(i, v, v at(0) < credit)
	indices := solve(credit, cand) map(i, v, v at(1)) sort join(" ")
	("Case #" .. (n+1) .. ": " .. indices) println
)
