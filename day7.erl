-module(day7).
-export([main/1]).
-mode(compile).
 -define(INPUT, <<"input/day7">>).
%-define(INPUT, <<"input/day7_sample">>).

sum(X) -> (X * (X + 1)) div 2.

part2(List) ->
  Sum = lists:sum(List),
  Len = length(List),
  Avg = trunc(Sum / Len),
  lists:sum([sum(abs(X - Avg)) || X <- List]).

part1(List) ->
  Range = lists:seq(lists:min(List), lists:max(List)),
  lists:min([lists:sum([abs(X - C) || X <- List]) || C <- Range]).

main(["1"]) ->
  {ok, Input} = file:read_file(?INPUT),
  Start = erlang:monotonic_time(nanosecond),
  List = [binary_to_integer(X) || X <- string:split(Input, ",", all)],
  Result = part1(List),
  End = erlang:monotonic_time(nanosecond),
  io:fwrite("Result: ~p~nTook: ~p~n", [Result, (End - Start) / 1000000000]);
main(["2"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [binary_to_integer(X) || X <- string:split(Input, ",", all)],
  Start = erlang:monotonic_time(nanosecond),
  List = [binary_to_integer(X) || X <- string:split(Input, ",", all)],
  Result = part2(List),
  End = erlang:monotonic_time(nanosecond),
  io:fwrite("Result: ~p~nTook: ~p~n", [Result, (End - Start) / 1000000000]).
