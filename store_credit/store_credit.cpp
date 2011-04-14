#include <vector>
#include <algorithm>
#include <ext/functional>
#include <iostream>

using namespace std;
using namespace __gnu_cxx;

typedef pair<int, int> Item;

pair<Item, Item> solve(int credit, vector<Item>& items) {
	Item last = items.back();
	items.pop_back();	
	vector<Item>::iterator p = find_if(items.begin(), items.end(), compose1(
		bind2nd(equal_to<int>(), credit - last.first), 
		select1st<Item>()
	));
	if (p != items.end()) {
		return pair<Item, Item>(last, *p);
	} else {
		if (items.size() <= 2) abort();
		return solve(credit, items);
	} 
}

int main() {
	int N, credit, count, value;
	cin >> N;
	for (int n = 1; n <= N; n++) {
		cin >> credit;
		cin >> count;
		vector<Item> items;
		for (int i = 1; i <= count; i++) {
			cin >> value;
			items.push_back(Item(value, i));
		}
		// items.erase(remove_if(items.begin(), items.end(), compose1(
		//  	bind2nd(greater<int>(), credit), select1st<Item>()
		// )), items.end());
		pair<Item, Item> r = solve(credit,  items);
		int values[2] = {r.first.second, r.second.second};
		sort(&values[0], &values[2]);
		cout << "Case #" << n << ": " << values[0] << " " << values[1] << endl;
	}
	return 0;
}