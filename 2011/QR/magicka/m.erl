-module(m).
-export([main/1]).

combine(Elements, _) when length(Elements) < 2 ->
	Elements;
combine(Elements, CombinesT) ->
	L2 = lists:sort(lists:sublist(Elements, length(Elements) - 1, 2)),
	case ets:lookup(CombinesT, L2) of
		[] ->
			Elements;
		[{_, Tobe}] ->
			lists:sublist(Elements, 1, length(Elements) - 2) ++ [Tobe]
	end.

clear(Elements, _) when length(Elements) < 2 ->
	Elements;
clear(Elements, Opposeds) ->
	LChr = lists:last(Elements),
	Reduced = lists:filter(fun(O) -> string:chr(O, LChr) > 0 end, Opposeds),
	case lists:any(fun(E) -> length(lists:subtract(E, Elements)) == 0 end, Reduced) of
		true -> [];
		false -> Elements
	end.
	
invoke(_C, _O, Inputs, Elements) when length(Inputs) == 0 ->
	Elements;
invoke(CombinesT, Opposeds, [E|Inputs], Elements) ->
	NE = clear(combine(Elements ++ [E], CombinesT), Opposeds),
	invoke(CombinesT, Opposeds, Inputs, NE).

solve_print(I, Elements) ->
	EList = lists:map(fun(E) -> [E] end, Elements),
	io:format("Case #~p: [~s]~n", [I + 1, string:join(EList, ", ")]).
	
line() -> lists:delete(10, io:get_line("")).
to_int(S) ->
	{I, _} = string:to_integer(S),
	I.

solve_each(N, N) ->
	ok;
solve_each(I, N) ->
	[C|V1] = string:tokens(string:strip(line()), " "),
	{Combines, [D|V2]} = lists:split(to_int(C), V1),
	{Opposeds, [_|Elements]} = lists:split(to_int(D), V2),
	CombinesT = ets:new(combines, [bag]),
	lists:foreach(fun(Cb) ->
		ets:insert(CombinesT, {lists:sort(string:substr(Cb, 1, 2)), lists:last(Cb)}) end, Combines),
	solve_print(I, invoke(CombinesT, Opposeds, lists:last(Elements), [])),
	ets:delete(CombinesT),
	solve_each(I + 1, N).		
main(_Args) ->
	solve_each(0, to_int(line())).