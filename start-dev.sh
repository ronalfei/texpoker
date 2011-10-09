#!/bin/sh
# NOTE: mustache templates need \ because they are not awesome.
exec erl -pa ebin edit deps/*/ebin -boot start_sasl +K true +P 655350\
    -name texpoker_dev@127.0.0.1 \
	-setcookie riak \
    -s texpoker \
    -s reloader
