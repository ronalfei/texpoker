-module(texpoker_util).
-include("texpoker.hrl").

-compile(export_all).

sort(L) when is_list(L) -> lists:sort(fun(T1,T2) -> compare_value(T1,T2) end , L).

rsort(L) -> lists:reverse(?MODULE:sort(L)).

hex_to_int(L) ->
	my_http_util:hexlist_to_integer(L).

int_to_hex( Int ) ->
	string:to_lower(my_http_util:integer_to_hexlist( Int )).


reverse_proplists(L) ->
	[{V, K}|| {K, V} <- L ].

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
	R1 = sort(L),
	R2 = rsort(L),
	?dbg1("test dbg1"),
	?dbg2("excute sort method ~p : ~p", [L, R1]),
	lager:info("excute sort method ~p : ~p", [L, R2]).
