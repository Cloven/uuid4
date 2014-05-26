-module(uuid4).
-vsn("1.0.0").
-author("felixgallo@gmail.com").

-export([uuid4/0, test_uuid4/0, test_uuid4_helper/1]).

%% UUID4 is 122 bits of entropy; we need 16 8-bit bytes to get that.
%% example UUID4 (thanks Wikipedia): f47ac10b-58cc-4372-a567-0e02b2c3d479
%% for unknown reasons, the third group of characters must start with the number 4.
%% for further unknown reasons, the fourth group of characters must start with 8, 9, a or b.

-spec(uuid4() -> binary()).
uuid4() ->
  RandomBytes = crypto:rand_bytes(16),
  <<First:32, Second:16, Third:12, Fourth:2, Fifth:12, Sixth:48, _UselessPadding:6, _Rest/binary>> = RandomBytes,
 list_to_binary(io_lib:format("~8.16.0b-~4.16.0b-4~3.16.0b-~1.16.0b~3.16.0b-~12.16.0b",[First,Second,Third,Fourth+8,Fifth,Sixth])).

-spec(test_uuid4() -> 'ok').
test_uuid4() ->
  Ret = timer:tc(uuid4, test_uuid4_helper, [1000000]),
  io:format("~p~n",[Ret]),
  ok.

-spec(test_uuid4_helper(_I) -> 'ok').
test_uuid4_helper(0) -> ok;
test_uuid4_helper(N) ->
  _Z = uuid4(),
  test_uuid4_helper(N-1).
