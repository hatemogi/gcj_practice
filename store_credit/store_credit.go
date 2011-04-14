package main

import (
	"fmt" 
)

type Item struct {
	value int
	index int
}

func solve(credit int, items []Item) (Item, Item) {
	head := items[0]
	for i := 1; i < len(items); i++ {
		if (items[i].value + head.value == credit) {
			return head, items[i]
		}
	}
	return solve(credit, items[1:len(items)])
}

func main() {
	var n, credit, count, value int
	fmt.Scanf("%d", &n)
	for i := 1; i <= n; i++ {
		fmt.Scanf("%d", &credit)
		fmt.Scanf("%d", &count)
		items := make([]Item, count)
		for t := 0; t < count; t++ {
			fmt.Scanf("%d", &value)
			items[t] = Item{value, t + 1}
		}
		r1, r2 := solve(credit, items[:])
		i1, i2 :=  r1.index, r2.index
		if (i1 > i2) {
			i1, i2 = i2, i1
		}
		fmt.Printf("Case #%d: %d %d\n", i, i1, i2)
	}
}
