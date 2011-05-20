-module(bt).
-export([main/1]).

find(Credit, [{Pivot, PivotIdx}|Items]) ->
	case lists:dropwhile(fun({E, _}) -> Pivot + E /= Credit end, lists:reverse(Items)) of
		[] ->
			find(Credit, Items);
		[Matched|_Rest] ->
			[{Pivot, PivotIdx}, Matched]
	end.
		
solve(Credit, Items) ->
	Indexed = lists:zip(Items, lists:seq(1, length(Items))),
	Filtered = [{E, Idx} || {E, Idx} <- Indexed, E < Credit],
	Candidates = lists:reverse(lists:keysort(1, Filtered)),
	{_, Indice} = lists:unzip(find(Credit, Candidates)),
	lists:sort(Indice).	

solve_print(I, Credit, Items) ->
	Indice = solve(Credit, Items),
	io:format("Case #~p: ~p ~p~n", [I + 1] ++ Indice).
	
line() -> io:get_line("").
to_int(S) ->
	{I, _} = string:to_integer(S),
	I.
line_to_integers(L) ->
	[to_int(E) || E <- string:tokens(L, " ")].
			
solve_each(N, N) ->
	ok;
solve_each(I, N) ->
	Credit = to_int(line()),
	line(),
	Items = line_to_integers(line()),
	solve_print(I, Credit, Items),
	solve_each(I + 1, N).		
main(_Args) ->
	solve_each(0, to_int(line())).
