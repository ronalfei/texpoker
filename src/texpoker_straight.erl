-module(texpoker_straight).
-include("texpoker.hrl").

-compile(export_all).


get_straight( L ) when length(L) >= 5 -> % if length < 5 , that is not regular list
	L1 = texpoker_util:reverse_proplists(L),
	Points = proplists:get_keys(L1),
	R1 = case length(Points) < 5 of
		true ->
			[];
		_    ->	
			case lists:member(?A,Points) of 
				true	-> [ "1" | Points];		%may be staight is A,2,3,4,5  in this case A = 1
				false	-> Points
			end
	end,
	R2 = to_int(R1),
	R3 = lists:sort(fun(X,Y) -> rsort(X,Y)  end ,R2), %R3 is a order list by desc ,like  9,7,5,3,2
	Ret = case length(R3) of
		5 ->
			substraight(R3, 1, 1);
		6 ->
			substraight(R3, 2, 1);
		7 ->
			substraight(R3, 3, 1);
		8 ->
			substraight(R3, 4, 1)
	end,
	case Ret of
		[] -> [];
		_  -> return_proplist( Ret, L1)
	end;
get_straight( _L ) -> [].





%%------internal functions------------
substraight(L, Total, _N) when Total =< 0 -> 
	[H | _T] = L,
    NewList = lists:seq(H,H-4,-1),
    is_equal_list(L,NewList);
substraight(_L, Total, N) when Total<N -> [];
substraight(L, Total, N) ->
	SubList = lists:sublist(L, N, 5),
    [H | _T] = SubList,
    NewList = lists:seq(H, H-4, -1),
    case is_equal_list(SubList, NewList) of
        [] -> substraight(L, Total, N+1);            
        _  -> NewList
    end.


to_int(L) ->
	[texpoker_util:to_int(X) || X <- L].


rsort(X, Y) ->
	if 
		X > Y -> true;
		true  -> false
	end.


is_equal_list(L1,L2) ->
	if
		L1=:=L2 -> L2;
		true    -> []
    end.

return_proplist(IntList,PropList) ->
	[ {proplists:get_value(texpoker_util:to_hex(X), PropList), texpoker_util:to_hex(X)}|| X <- IntList ].
%%-------------test ------------------

test() ->
	L1 = [{"spade","b"},{"heart","a"},{"diamond","8"},{"club","7"},{"club","9"},{"heart","b"},{"spade","5"}],
	A = ?MODULE:get_straight(L1),
	?dbg2(" straight test for L1 : ~p ~n",[A]),
	L2 = [{?C,"8"},{?C,"4"},{?C,"7"},{"heart","6"},{?C,"5"}],
	B = ?MODULE:get_straight(L2),
	?dbg2("straight test for L2 : ~p ~n",[B]),
	L3 = [{?C,"b"},{?C,"a"},{?C,"c"},{?C,"e"},{?C,"d"}],
	C = ?MODULE:get_straight(L3),
	?dbg2("straight test for L3 : ~p ~n",[C]),
	L4 = [{?C,"b"},{?C,"a"},{?C,"c"},{?C,"9"},{?C,"d"},{?C,"e"}],
	D = ?MODULE:get_straight(L4),
	?dbg2("straight test for L4 : ~p ~n",[D]),
	L5 = [{?C,"8"},{?C,"4"},{?C,"7"},{"heart","9"},{?C,"5"}],
	E = ?MODULE:get_straight(L5),
	?dbg2("straight test for L5 : ~p ~n",[E]),
    L6 = [{?C,"3"},{?C,"4"},{?C,"e"},{"heart","2"},{?C,"5"}],
    F = ?MODULE:get_straight(L6),
    ?dbg2("straight test for L6 : ~p ~n",[F]),
	?dbg2("L 13: ~p ", [[13,12,8,16]]),
	"over".
