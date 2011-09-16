%% @author Mochi Media <dev@mochimedia.com>
%% @copyright texpoker Mochi Media <dev@mochimedia.com>

%% @doc Callbacks for the texpoker application.

-module(texpoker_app).
-author("Mochi Media <dev@mochimedia.com>").

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for texpoker.
start(_Type, _StartArgs) ->
    texpoker_deps:ensure(),
    texpoker_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for texpoker.
stop(_State) ->
    ok.
