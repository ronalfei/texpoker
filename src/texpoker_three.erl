-module(texpoker_three).
-include("texpoker.hrl").

-compile(export_all).


get_three( L ) ->
	RL = texpoker_util:reverse_proplists(L),
	V = proplists:get_keys(RL),
	case get_3count(RL, V) of
		[] -> [];
		RV -> 
			R1 = proplists:lookup_all(RV, RL),
			V2 = [Y || Y <- V, Y=/=RV],
			[H1, H2|_T] = lists:sort(fun(X,Y)->texpoker_util:rsort(X,Y) end,V2),
			R2 = proplists:lookup(H1, RL),
			R3 = proplists:lookup(H2, RL),
			R = lists:append(R1,[R2,R3]),
			texpoker_util:reverse_proplists(R)
	end.




%%------internal function -------------------
get_3count(_SourceList, []) ->
	[];
get_3count(SourceList, [H|T]) ->
	L = proplists:get_all_values(H, SourceList),
	Len = length(L),
	case Len of
		3 -> H;
		_Any -> get_3count(SourceList, T)
	end.	
	
%%------------- test ------

test() ->
	L1 = [{"spade","b"},{"heart","a"},{"diamond","b"},{"club","b"},{"club","9"},{"heart","b"},{"spade","5"}],
	A = ?MODULE:get_three(L1),
	?dbg2("test for L1 : ~p",[A]),
	L2 = [{"spade","b"},{"heart","a"},{"diamond","b"},{"club","b"},{"club","9"},{"heart","6"},{"spade","a"}],
	B = ?MODULE:get_three(L2),
	?dbg2("test for L2 : ~p",[B]).
