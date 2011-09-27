#!/bin/sh
# NOTE: mustache templates need \ because they are not awesome.
exec erl -pa ebin edit deps/*/ebin -boot start_sasl +K true +P 655350\
    -sname texpoker_dev \
    -s texpoker \
    -s reloader
