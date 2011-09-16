-compile([{parse_transform, lager_transform}]).


-define(dbg1(Str),lager:info(Str)).
-define(dbg2(Str, Data),
	lager:info(atom_to_list(?MODULE)++":"++integer_to_list(?LINE)++":"++Str
				, Data)
			).

-define(S, "spade").
-define(H, "heart").
-define(D, "diamond").
-define(C, "club").
-define(FL, [ ?S, ?H, ?D, ?C]).
-define(A, "e").
