-module(texpoker_apair).
-include("texpoker.hrl").

-compile(export_all).


get_apair( L ) ->
	RL = texpoker_util:reverse_proplists(L),
	V = lists:sort(fun(X, Y) -> texpoker_util:rsort(X, Y) end, proplists:get_keys(RL)),
	case get_two(RL, V) of
		[] -> [];
		RV -> 
			[RV2,RV3,RV4|_T] = [Y || Y <- V, Y=/=RV],
			R1 = proplists:lookup_all(RV , RL),
			R2 = proplists:lookup(RV2, RL),
			R3 = proplists:lookup(RV3, RL),
			R4 = proplists:lookup(RV4, RL),
			R  = lists:flatten(lists:append( R1, [R2, R3, R4])),
			texpoker_util:reverse_proplists(R)
	end.




%%------internal function -------------------
get_two(_SourceList, []) ->
	[];
get_two(SourceList, [H|T]) ->
	L = proplists:get_all_values(H, SourceList),
	Len = length(L),
	case Len of
		2 -> H;
		_Any -> get_two(SourceList, T)
	end.	
	
%%------------- test ------

test() ->
	L1 = [{"spade","b"},{"heart","a"},{"diamond","7"},{"club","b"},{"club","9"},{"heart","7"},{"spade","5"}],
	A = ?MODULE:get_apair(L1),
	?dbg2("test for L1 : ~p",[A]),
	L2 = [{"spade","2"},{"heart","a"},{"diamond","4"},{"club","e"},{"club","9"},{"heart","9"},{"spade","a"}],
	B = ?MODULE:get_apair(L2),
	?dbg2("test for L2 : ~p",[B]).
