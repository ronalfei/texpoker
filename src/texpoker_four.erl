-module(texpoker_four).
-include("texpoker.hrl").

-compile(export_all).


get_four( L ) -> 
	Tab = ets:new(slist, [bag, private]),
	ets:insert( Tab,  L),
	Vs = texpoker_util:get_values(L),
	?dbg2("vs = ~p ---- Tab = ~p", [Vs, ets:tab2list(Tab)]),
	[ ets:match(Tab, {'_', X} ) || X <- Vs]
	
	.





%%------------- test ------

test() ->
	L1 = [{"spade","b"},{"heart","a"},{"diamond","b"},{"club","b"},{"club","9"},{"heart","b"},{"spade","5"}],
	A = ?MODULE:get_four(L1),
	?dbg2("test for L1 : ~p",[A]),
	L2 = [{"spade","b"},{"heart","a"},{"diamond","b"},{"club","b"},{"club","9"},{"heart","6"},{"spade","a"}],
	B = ?MODULE:get_four(L2),
	?dbg2("test for L2 : ~p",[B]).
