-module(texpoker_tpairs).
-include("texpoker.hrl").

-compile(export_all).


get_tpairs( L ) ->
	RL = texpoker_util:reverse_proplists(L),
	V = lists:sort(fun(X, Y) -> texpoker_util:rsort(X, Y) end, proplists:get_keys(RL)),
	case get_two(RL, V) of
		[] -> [];
		RV -> 
			V2 = [Y || Y <- V, Y=/=RV],
			case get_two(RL, V2) of 
				[] -> [];
				RV2-> 
					[RV3 | _T] = [Y || Y <- V2, Y=/=RV2],
					R1 = proplists:lookup_all(RV , RL),
					R2 = proplists:lookup_all(RV2, RL),
					R3 = proplists:lookup(RV3, RL),
					R  = lists:flatten(lists:append( R1, [R2, R3])),
					texpoker_util:reverse_proplists(R)
			end
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
	A = ?MODULE:get_tpairs(L1),
	?dbg2("test for L1 : ~p",[A]),
	L2 = [{"spade","b"},{"heart","a"},{"diamond","b"},{"club","b"},{"club","9"},{"heart","9"},{"spade","a"}],
	B = ?MODULE:get_tpairs(L2),
	?dbg2("test for L2 : ~p",[B]).
