object StoreCredit extends Application {	
	type Item = (Int, Int)
	
	def solve(credit: Int, items: List[Item]): (Item, Item) = {
		val it = items.iterator
		val head = it.next
		val m = it.find((e: Item) => head._1 + e._1 == credit)
		if (m != None) {
			return (head, m.get)
		}
		solve(credit, items.slice(1, items.length))
	}
	
	val N = readInt()
	for (n <- List.range(1, N + 1)) {
		val credit = readInt()
		val count = readInt()
		val values = readLine.split(" ").map((s: String) => s.toInt)
		val items = values.toList.zip(List.range(1, count + 1))
		val r = solve(credit, items)
		val indice = List(r._1._2, r._2._2).sortWith((a, b) => a < b).mkString(" ")
		println("Case #" + n + ": " + indice)		
	}
}
