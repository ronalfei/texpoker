-module(texpoker_util).
-include("texpoker.hrl").

-compile(export_all).

proplists_sort(L) when is_list(L) -> lists:sort(fun(T1,T2) -> compare_value(T1,T2) end , L).

proplists_rsort(L) -> lists:reverse(proplists_sort(L)).

hex_to_int(L) ->
	mochihex:to_int(L).

int_to_hex( Int ) ->
	string:to_lower(my_http_util:integer_to_hexlist( Int )).

to_int( "1" ) -> 1;
to_int( "2" ) -> 2;
to_int( "3" ) -> 3;
to_int( "4" ) -> 4;
to_int( "5" ) -> 5;
to_int( "6" ) -> 6;
to_int( "7" ) -> 7;
to_int( "8" ) -> 8;
to_int( "9" ) -> 9;
to_int( "a" ) -> 10;
to_int( "b" ) -> 11;
to_int( "c" ) -> 12;
to_int( "d" ) -> 13;
to_int( "e" ) -> 14;
to_int( Hex ) -> mochihex:to_int(Hex).

to_hex( 1 ) -> "e";
to_hex( 2 ) -> "2";
to_hex( 3 ) -> "3";
to_hex( 4 ) -> "4";
to_hex( 5 ) -> "5";
to_hex( 6 ) -> "6";
to_hex( 7 ) -> "7";
to_hex( 8 ) -> "8";
to_hex( 9 ) -> "9";
to_hex( 10 ) -> "a";
to_hex( 11 ) -> "b";
to_hex( 12 ) -> "c";
to_hex( 13 ) -> "d";
to_hex( 14 ) -> "e";
to_hex( Int ) -> mochihex:to_hex(Int).


reverse_proplists(L) ->
	[{V, K}|| {K, V} <- L ].

get_values(L) -> 
	[V || {_K, V} <- L ].

get_proplists_values(L) ->
	proplists:get_keys(reverse_proplists(L)).

get_sort_values(L) ->
	L1 = [V || {_K, V} <- L ],
	lists:sort(fun(X, Y) -> sort(X, Y) end, L1).

get_rsort_values(L) ->
	L1 = [V || {_K, V} <- L ],
	lists:sort(fun(X,Y ) -> rsort(X, Y)  end,  L1).
rsort( X, Y) when X > Y -> true;
rsort(_X,_Y) -> false.

sort( X, Y) when X > Y -> false;
sort(_X,_Y) -> true.


for(N, M, _F ) when N > M -> ok;	

for(N, M, F ) ->
	F(N),
	for(N+1, M, F).






%%--internal function----
compare_value({_K1,V1},{_K2,V2}) ->
	if 
		V1 =< V2 -> true ;
		true	 -> false
	end.

%%----set log level to error-----
stop_log() ->
	lager:set_loglevel(lager_console_backend, error).

%% set log level to info
start_log() ->
	lager:set_loglevel(lager_console_backend, info).


%%-----test--------------
test() ->
	L = [ {?S,		"b"}
		, {"heart",		"a"}
		, {"diamond",	"8"}
		, {"club",		"4"}
		, {"club",		"9"}
		, {"heart",		"b"}
		, {"spade",		"5"} ],
	R1 = proplists_sort(L),
	R2 = proplists_rsort(L),
	?dbg1("test dbg1"),
	?dbg2("excute sort method ~p : ~p", [L, R1]),
	lager:info("excute sort method ~p : ~p", [L, R2]).
