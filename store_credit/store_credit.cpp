#include <vector>
#include <algorithm>
#include <ext/functional>
#include <iostream>

using namespace std;
using namespace __gnu_cxx;

typedef pair<int, int> Item;
typedef vector<Item>::iterator vit;

pair<Item, Item> solve(int credit, vit pos, vit end) {
	Item head = *pos++;
	vit p = find_if(pos, end, compose1(
		bind2nd(equal_to<int>(), credit - head.first), 
		select1st<Item>()
	));
	if (p != end) {
		return pair<Item, Item>(head, *p);
	} 
	return solve(credit, pos, end);
}

int main() {
	int N, credit, count, value;
	cin >> N;
	for (int n = 1; n <= N; n++) {
		cin >> credit >> count;
		vector<Item> items;
		for (int i = 1; i <= count; i++) {
			cin >> value;
			if (value < credit) {
				items.push_back(Item(value, i));				
			}
		}
		pair<Item, Item> r = solve(credit,  items.begin(), items.end());
		int values[] = {r.first.second, r.second.second};
		sort(values, &values[2]);
		cout << "Case #" << n << ": " << values[0] << " " << values[1] << endl;
	}
	return 0;
}