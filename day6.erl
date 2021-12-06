-module(day5).
-export([main/1]).
-mode(compile).
 -define(INPUT, <<"input/day6">>).
%-define(INPUT, <<"input/day6_sample">>).

update(X, 0) -> lists:sum(X);
update([A,B,C,D,E,F,G,H,I], N) -> update([B,C,D,E,F,G,H+A,I,A], N-1).

main(["1"]) ->
  {ok, Input} = file:read_file(?INPUT),
  I = [binary_to_integer(X) || X <- string:split(Input, ",", all)],
  Init = [length([Y||Y<-I, Y =:= X]) || X <- lists:seq(0, 8)],
  io:fwrite("~p~n", [update(Init, 80)]);
main(["2"]) ->
  {ok, Input} = file:read_file(?INPUT),
  I = [binary_to_integer(X) || X <- string:split(Input, ",", all)],
  Init = [length([Y||Y<-I, Y =:= X]) || X <- lists:seq(0, 8)],
  io:fwrite("~p~n", [update(Init, 256)]),
  ok.

