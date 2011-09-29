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
