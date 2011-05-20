#include <vector>
#include <map>
#include <algorithm>
#include <ext/functional>
#include <ext/numeric>
#include <iostream>
#include <string>
#include <sstream>

using namespace std;
using namespace __gnu_cxx;

int64_t _patrick_sum(int64_t r, const int64_t &v) {
	return (r | v) & ~(r & v);
}

inline int64_t patrick_sum(vector<int64_t> &v) {
	return accumulate(v.begin(), v.end(), (int64_t)0, _patrick_sum);
}

inline int64_t sum(vector<int64_t> &v) {
	return accumulate(v.begin(), v.end(), 0);
}

string search_key(vector<int64_t> v) {
	std::ostringstream r; 
	sort(v.begin(), v.end());
	for (vector<int64_t>::iterator p = v.begin(); p < v.end(); p++) {
	 	r << *p << ",";
	}
	return r.str();
}

int64_t solve(vector<int64_t>& seans, vector<int64_t>& patricks, int64_t best, map<string, int64_t>& cache) {
	string key = search_key(seans);
	map<string, int64_t>::iterator c = cache.find(key);
	if (c != cache.end()) return c->second;
	cache[key] = best;

	int64_t seans_v = sum(seans);
	if (seans_v <= best) return best;
	int64_t patricks_v = sum(patricks);
	if (patricks_v > seans_v) return best;

	if (patricks.size() > 0 && patrick_sum(seans) == patrick_sum(patricks)) {
		best = seans_v;		
		cache[key] = best;
		return best;
	}

	if (seans.size() > 1) {
		for (vector<int64_t>::iterator p = seans.begin(); p < seans.end(); p++) {
			vector<int64_t> ns = seans;
			vector<int64_t> np = patricks;
			int64_t e = *p;
			ns.erase(ns.begin() + (p - seans.begin())); 
			np.push_back(e);
			uint64_t r = solve(ns, np, best, cache);
			if (r > best) best = r;
		}		
	}
	return best;
}

int main() {
	int64_t N, count, value;
	cin >> N;
	for (int n = 1; n <= N; n++) {
		cin >> count;
		vector<int64_t> seans, patricks;
		for (int i = 1; i <= count; i++) {
			cin >> value;
			seans.push_back(value);				
		}
		map<string, int64_t> cache;
		int64_t r = solve(seans, patricks, 0, cache);
		cout << "Case #" << n << ": ";
		if (r > 0) { cout << r; } else { cout << "NO"; }
		cout << endl;
	}
	return 0;
}