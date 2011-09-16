-module(texpoker_four).
-include("texpoker.hrl").

-compile(export_all).


get_four( L ) -> 
	proplists:compact(L).





%%-------------test ------

test() ->
	L1 = [{"spade","b"},{"heart","a"},{"diamond","b"},{"club","b"},{"club","9"},{"heart","b"},{"spade","5"}],
	A = ?MODULE:get_four(L1),
	?dbg2("test for L1 : ~p",[A]),
	L2 = [{"spade","b"},{"heart","a"},{"diamond","b"},{"club","b"},{"club","9"},{"heart","6"},{"spade","a"}],
	B = ?MODULE:get_four(L2),
	?dbg2("test for L1 : ~p",[B]).
