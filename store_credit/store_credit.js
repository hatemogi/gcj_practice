// JavaScript file for running on node.js

function solve(credit, items) {
	var head = items.shift();
	var found;
	if (items.some(function(e) { found = e; return e[0] + head[0] == credit })) {
		return [head, found];
	}
	return solve(credit, items);
}

var buffer = "";
process.stdin.on('data', function(chunk) {
	buffer = buffer + chunk;
});

process.stdin.on('end', function() {
	var lines = buffer.split("\n");
	var N = parseInt(lines.shift());
	for (n = 1; n <= N; n++) {
		var credit = parseInt(lines.shift());
		lines.shift();
		var index = 1;
		var values = lines.shift().split(" ").map(function(e) { return [parseInt(e), index++] });
		var r = solve(credit, values).map(function(e) { return parseInt(e[1]) }).sort(function(a, b) {
			return (a > b) ? 1 : -1;
		});
		console.log("Case #" + n + ": " + r.join(" "));		
	}
});

process.stdin.resume();