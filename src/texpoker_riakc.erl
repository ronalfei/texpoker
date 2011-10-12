-module(texpoker_riakc).

-include("texpoker.hrl").

-compile(export_all).


connect() -> 
	{ok, Pid} = riakc_pb_socket:start_link(?RIAK_HOST, ?RIAK_PORT),
	Pid.

new(Key, Value) -> 
	Object = riakc_obj:new(?BUCKET, Key, Value),
	Object.

save(Pid,Object) ->
	 riakc_pb_socket:put(Pid,Object).

stop(Pid) ->
	 riakc_pb_socket:stop(Pid).



pset(Pid, Key, Value) -> 
	Object = new(Key,Value),
    save(Pid, Object),
	Pid.

set(Key,Value) -> 
	Object = new(Key,Value),
	Pid = connect(),
	save(Pid, Object),
	stop(Pid).


connect1() -> 
	%case net_adm:ping(?RIAK_NODE) of
	%	pong ->	
	%		case riak:client_connect(?RIAK_NODE) of
	%			{ok, C} -> C;
	%			  Any   -> lager:error("connect error: ~p ", [Any])
	%		end;
	%	 _   ->
	%		lager:error("can not connect riak node: ~p ",[?RIAK_NODE])
	%end.

	{ok, C} = riak:client_connect(?RIAK_NODE),
	C.

new1(Key, Value) ->
    Object = riakc_obj:new(?BUCKET, Key, Value),
    Object.

save1(C,Object) ->
     C:put(Object, 1).

stop1(C) ->
     C:stop(C).


pset1(C, Key, Value) ->
    Object = new1(Key,Value),
    save1(C, Object),
    C.

set1(Key,Value) ->
    Object = new1(Key,Value),
    C = connect1(),
    save1(C, Object),
    stop1(C).



%%Now that you have a functional server, let’s try storing some data in it. First, start up a erlang node using our embedded version of erlang:
%%   $ erts-<vsn>/bin/erl -name riaktest@127.0.0.1 -setcookie riak
%%   
%%   Eshell V5.7.4  (abort with ^G)
%%   (riaktest@127.0.0.1)1>
%%
%%
%%Now construct the node name of Riak server and make sure we can talk to it:
%%   (riaktest@127.0.0.1)4> RiakNode = 'riak@127.0.0.1'.
%%
%%   (riaktest@127.0.0.1)2> net_adm:ping(RiakNode).
%%   pong
%%   (riaktest@127.0.0.1)2>
%%
%%
%%We are now ready to start the Riak client:
%%{ok, C} = riak:client_connect(RiakNode).
%%   {ok,{riak_client,'riak@127.0.0.1',<<4,136,81,151>>}}
%%
%%
%%Let’s create a shopping list for bread at /groceries/mine:
%%   (riaktest@127.0.0.1)6> O0 = riak_object:new(<<"groceries">>, <<"mine">>, ["bread"]).
%%   O0 = riak_object:new(<<"groceries">>, <<"mine">>, ["bread"]).
%%   {r_object,<<"groceries">>,<<"mine">>,
%%          [{r_content,{dict,0,16,16,8,80,48,
%%                            {[],[],[],[],[],[],[],[],[],[],[],[],[],[],...},
%%                            {{[],[],[],[],[],[],[],[],[],[],[],[],...}}},
%%                      ["bread"]}],
%%          [],
%%          {dict,1,16,16,8,80,48,
%%                {[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],...},
%%                {{[],[],[],[],[],[],[],[],[],[],[],[],[],...}}},
%%          undefined}
%%
%%    (riaktest@127.0.0.1)3> C:put(O0, 1).
%%
%%
%%
%%Now, read the list back from the Riak server and extract the value
%%    (riaktest@127.0.0.1)4> {ok, O1} = C:get(<<"groceries">>, <<"mine">>, 1).
%%    {ok,{r_object,<<"groceries">>,<<"mine">>,
%%              [{r_content,{dict,2,16,16,8,80,48,
%%                                {[],[],[],[],[],[],[],[],[],[],[],[],...},
%%                                {{[],[],[],[],[],[],
%%                                  [["X-Riak-Last-Modified",87|...]],
%%                                  [],[],[],...}}},
%%                          ["bread"]}],
%%              [{"20090722191020-riaktest@127.0.0.1-riakdemo@127.0.0.1-266664",
%%                {1,63415509105}}],
%%              {dict,0,16,16,8,80,48,
%%                    {[],[],[],[],[],[],[],[],[],[],[],[],[],...},
%%                    {{[],[],[],[],[],[],[],[],[],[],[],...}}},
%%              undefined}}
%%
%%     (riaktest@127.0.0.1)5> %% extract the value
%%     (riaktest@127.0.0.1)5> V = riak_object:get_value(O1).
%%     ["bread"]
%%
%%
%%Add milk to our list of groceries and write the new value to Riak:
%%     (riaktest@127.0.0.1)6> %% add milk to the list
%%     (riaktest@127.0.0.1)6> O2 = riak_object:update_value(O1, ["milk" | V]).
%%     {r_object,<<"groceries">>,<<"mine">>,
%%          [{r_content,{dict,2,16,16,8,80,48,
%%                            {[],[],[],[],[],[],[],[],[],[],[],[],[],[],...},
%%                            {{[],[],[],[],[],[],
%%                              [["X-Riak-Last-Modified",87,101,100|...]],
%%                              [],[],[],[],[],...}}},
%%                      ["bread"]}],
%%          [{"20090722191020-riaktest@127.0.0.1-riakdemo@127.0.0.1-266664",
%%            {1,63415509105}}],
%%          {dict,0,16,16,8,80,48,
%%                {[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],...},
%%                {{[],[],[],[],[],[],[],[],[],[],[],[],[],...}}},
%%          ["milk","bread"]}
%%
%%     (riaktest@127.0.0.1)7> %% store the new list
%%     (riaktest@127.0.0.1)7> C:put(O2, 1).
%%     ok
%%
%%
%%Finally, see what other keys are available in groceries bucket:
%%(riaktest@127.0.0.1)8> C:list_keys(<<"groceries">>).
%%     {ok,[<<"mine">>]}
%%


