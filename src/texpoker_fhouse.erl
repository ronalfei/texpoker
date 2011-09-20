-module(texpoker_fhouse).
-include("texpoker.hrl").

-compile(export_all).


get_fhouse( L ) ->
	RL = texpoker_util:reverse_proplists(L),
	V = lists:sort(fun(X, Y) -> texpoker_util:rsort(X, Y) end, proplists:get_keys(RL)),
	case get_full(RL, V) of
		[] -> [];
		RV -> 
			V2 = [Y || Y <- V, Y=/=RV],
			case get_house(RL, V2) of 
				[] -> [];
				RV2-> 
					R1 = proplists:lookup_all(RV , RL),
					R2 = proplists:lookup_all(RV2, RL),
					R = lists:append( R1, R2 ),
					texpoker_util:reverse_proplists(R)
			end
	end.




%%------internal function -------------------
get_full(_SourceList, []) ->
	[];
get_full(SourceList, [H|T]) ->
	L = proplists:get_all_values(H, SourceList),
	Len = length(L),
	case Len of
		3 -> H;
		_Any -> get_full(SourceList, T)
	end.	
	
get_house(_SourceList, []) ->
    [];
get_house(SourceList, [H|T]) ->
    L = proplists:get_all_values(H, SourceList),
    Len = length(L),
    case Len of
        2 -> H;
        _Any -> get_house(SourceList, T)
    end.
%%------------- test ------

test() ->
	L1 = [{"spade","b"},{"heart","a"},{"diamond","b"},{"club","b"},{"club","9"},{"heart","b"},{"spade","5"}],
	A = ?MODULE:get_fhouse(L1),
	?dbg2("test for L1 : ~p",[A]),
	L2 = [{"spade","b"},{"heart","a"},{"diamond","b"},{"club","b"},{"club","9"},{"heart","9"},{"spade","a"}],
	B = ?MODULE:get_fhouse(L2),
	?dbg2("test for L2 : ~p",[B]).
