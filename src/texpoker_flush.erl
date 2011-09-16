-module(texpoker_flush).
-include("texpoker.hrl").

-compile(export_all).


get_flush( L ) -> 
	lists:flatten([count(K, L) || K <- ?FL ]).

count(K, L ) -> 
	L1 = proplists:lookup_all(K, L),
	if
		length(L1) >= 5 -> L1;
		true 			-> []
	end.





%%-------------test ------

test() ->
	L1 = [{"spade","b"},{"heart","a"},{"diamond","8"},{"club","4"},{"club","9"},{"heart","b"},{"spade","5"}],
	A = ?MODULE:get_flush(L1),
	?dbg2("test for L1 : ~p",[A]),
	L2 = [{?C,"b"},{?C,"a"},{?C,"8"},{?C,"4"},{?C,"9"},{"heart","b"},{?C,"5"}],
	B = ?MODULE:get_flush(L2),
	?dbg2("test for L1 : ~p",[B]).
