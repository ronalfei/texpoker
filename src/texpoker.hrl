-compile([{parse_transform, lager_transform}]).


-define(dbg1(Str),lager:info(Str)).
-define(dbg2(Str, Data), lager:info("~p:~p: " ++ Str, [?MODULE, ?LINE | Data])).


-define(S, "spade").
-define(H, "heart").
-define(D, "diamond").
-define(C, "club").
-define(FL, [ ?S, ?H, ?D, ?C ]).
-define(A, "e").

-define(TYPE_VALUE_SFLUSH,   "9").
-define(TYPE_VALUE_STRAIGHT, "8").
-define(TYPE_VALUE_FLUSH,    "7").
-define(TYPE_VALUE_FOUR,     "6").
-define(TYPE_VALUE_FHOUSE,   "5").
-define(TYPE_VALUE_THREE,    "4").
-define(TYPE_VALUE_TPAIRS,   "3").
-define(TYPE_VALUE_APAIR,    "2").
-define(TYPE_VALUE_HIGHC,    "1").


