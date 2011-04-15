import java.io.*;
import java.util.*;

class Item {
	int value, index;
	Item(int v, int i) { value = v; index = i; }
}

public class StoreCredit {
	static Item[] solve(int credit, List<Item> items) {
		Item head = items.remove(0);
		for (Item e: items) {
			if (e.value + head.value == credit) {
				return new Item[]{head, e};
			} 
		}
		return solve(credit, items);
	}
	
	public static void main(String[] args) throws Exception {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		int N = Integer.parseInt(in.readLine());
		for (int n = 1; n <= N; n++) {
			int credit = Integer.parseInt(in.readLine());
			in.readLine();
			ArrayList<Item> items = new ArrayList<Item>();
			int index = 0;
			for (String s: in.readLine().split(" ")) {
				index++;
				int value = Integer.parseInt(s);
				if (value < credit) {
					items.add(new Item(value, index));					
				}
			};
			Item[] r = solve(credit, items);
			int[] indice = {r[0].index, r[1].index};
			Arrays.sort(indice);
			System.out.println("Case #" + n + ": " + indice[0] + " " + indice[1]);
		}
	}
}