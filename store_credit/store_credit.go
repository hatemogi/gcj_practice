package main

import f "fmt"

type Item struct {
	value int
	index int
}

func solve(credit int, items []Item) (Item, Item) {
	for i := 1; i < len(items); i++ {
		if (items[0].value + items[i].value == credit) {
			return items[0], items[i]
		}
	}
	return solve(credit, items[1:])
}

func main() {
	var n, credit, count, value int
	f.Scanf("%d", &n)
	for i := 1; i <= n; i++ {
		f.Scanf("%d", &credit)
		f.Scanf("%d", &count)
		items := make([]Item, count)
		for t := 0; t < count; t++ {
			f.Scanf("%d", &value)
			items[t] = Item{value, t + 1}
		}
		r1, r2 := solve(credit, items[:])
		i1, i2 :=  r1.index, r2.index
		if (i1 > i2) {
			i1, i2 = i2, i1
		}
		f.Printf("Case #%d: %d %d\n", i, i1, i2)
	}
}
