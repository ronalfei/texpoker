%% @author Mochi Media <dev@mochimedia.com>
%% @copyright 2010 Mochi Media <dev@mochimedia.com>

%% @doc texpoker.

-module(texpoker).
-author("Mochi Media <dev@mochimedia.com>").
-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.


%% @spec start() -> ok
%% @doc Start the texpoker server.
start() ->
    texpoker_deps:ensure(),
	lager:start(),
    ensure_started(crypto),
    application:start(texpoker),
	texpoker_util:start_log().


%% @spec stop() -> ok
%% @doc Stop the texpoker server.
stop() ->
    application:stop(texpoker).
