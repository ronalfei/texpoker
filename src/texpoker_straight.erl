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
?dbg2("list R1 ~p ", [R1]),
	R2 = to_int(R1), %R2 is a order list by desc ,like  9,7,5,3,2
?dbg2("list R2  ~p ",[R2]),
	case length(R2) of
		5 ->
			[H | _T] = R2,	
			lists:seq(H,H-4,-1);
		6 ->
			6;
		7 ->
			7;
		8 ->
			8
	end;	

get_straight( _L ) -> [].





%%------internal functions------------
to_int(L) -> 
	to_int([], L).

to_int(T1, [H|T]) ->
?dbg2("this ~p ",[H]),
	to_int([ texpoker_util:hex_to_int(H) | T1] , T);
to_int(T1, []) -> 
	T1.


%%-------------test ------

test() ->
	L1 = [{"spade","b"},{"heart","a"},{"diamond","8"},{"club","7"},{"club","9"},{"heart","b"},{"spade","5"}],
	A = ?MODULE:get_straight(L1),
	?dbg2(" straight test for L1 : ~p",[A]),
	L2 = [{?C,"b"},{?C,"a"},{?C,"8"},{?C,"4"},{?C,"d"},{"heart","b"},{?C,"5"}],
	B = ?MODULE:get_straight(L2),
	?dbg2("straight test for L2 : ~p",[B]),
	L3 = [{?C,"b"},{?C,"a"},{?C,"c"},{?C,"e"},{?C,"d"}],
	C = ?MODULE:get_straight(L3),
	?dbg2("straight test for L3 : ~p",[C]),
	L4 = [{?C,"b"},{?C,"a"},{?C,"c"},{?C,"9"},{?C,"d"}],
	D = ?MODULE:get_straight(L4),
	?dbg2("straight test for L4 : ~p",[D]).
