-module(texpoker_four).
-include("texpoker.hrl").

-compile(export_all).


get_four( L ) ->
	RL = texpoker_util:reverse_proplists(L),
	V = proplists:get_keys(RL),
	case get_4count(RL, V) of
		[] -> [];
		RV -> 
			R1 = proplists:lookup_all(RV, RL),
			V2 = [Y || Y <- V, Y=/=RV],
			[H|_T] = lists:sort(fun(X,Y)->texpoker_util:rsort(X,Y) end,V2),
			R2 = proplists:lookup(H, RL),
			%R = R1 ++ R2,
			R = lists:append(R1,[R2]),
			texpoker_util:reverse_proplists(R)
	end.




%%------internal function -------------------
get_4count(_SourceList, []) ->
	[];
get_4count(SourceList, [H|T]) ->
	L = proplists:get_all_values(H, SourceList),
	Len = length(L),
	case Len of
		4 -> H;
		_Any -> get_4count(SourceList, T)
	end.	
	
%%------------- test ------

test() ->
	L1 = [{"spade","b"},{"heart","a"},{"diamond","b"},{"club","b"},{"club","9"},{"heart","b"},{"spade","5"}],
	A = ?MODULE:get_four(L1),
	?dbg2("test for L1 : ~p",[A]),
	L2 = [{"spade","b"},{"heart","a"},{"diamond","b"},{"club","b"},{"club","9"},{"heart","6"},{"spade","a"}],
	B = ?MODULE:get_four(L2),
	?dbg2("test for L2 : ~p",[B]).
