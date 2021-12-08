-module(day8).
-export([main/1]).
-mode(compile).
%-define(INPUT, <<"input/day8">>).
 -define(INPUT, <<"input/day8_sample">>).

main(["1"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [X || X <- string:split(Input, "\n", all), X /= ""],
  Result = part1(List),
  io:fwrite("Result: ~p~n", [Result]);
main(["2"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [binary_to_integer(X) || X <- string:split(Input, ",", all)],
  Start = erlang:monotonic_time(nanosecond),
  List = [binary_to_integer(X) || X <- string:split(Input, ",", all)],
  Result = part2(List),
  End = erlang:monotonic_time(nanosecond),
  io:fwrite("Result: ~p~nTook: ~p~n", [Result, (End - Start) / 1000000000]).
