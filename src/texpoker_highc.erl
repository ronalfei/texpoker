-module(texpoker_highc).
-include("texpoker.hrl").

-compile(export_all).


get_highc( L ) ->
	texpoker_util:proplists_rsort(L).





%%------------- test ------

test() ->
	L1 = [{"spade","b"},{"heart","a"},{"diamond","7"},{"club","b"},{"club","9"},{"heart","7"},{"spade","5"}],
	A = ?MODULE:get_highc(L1),
	?dbg2("test for L1 : ~p",[A]),
	L2 = [{"spade","2"},{"heart","a"},{"diamond","4"},{"club","e"},{"club","9"},{"heart","9"},{"spade","a"}],
	B = ?MODULE:get_highc(L2),
	?dbg2("test for L2 : ~p",[B]).
