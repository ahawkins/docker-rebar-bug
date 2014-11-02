-module(truth_test).

-include_lib("eunit/include/eunit.hrl").

truth_test() ->
  ?assertEqual(true, true).
