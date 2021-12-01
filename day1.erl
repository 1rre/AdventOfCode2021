-module(day1).
-export([main/1]).
-mode(compile).
-define(INPUT, <<"input/day1">>).

count3([A,B,C,D|List]) when B+C+D > A+B+C -> 1 + count3([B,C,D|List]);
count3([_|Tl]) -> count3(Tl);
count3([]) -> 0.

count([A,B|List]) when B > A -> 1 + count([B|List]);
count([_|Tl]) -> count(Tl);
count([]) -> 0.

main(["1"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [binary_to_integer(X) || X <- string:split(Input, "\n", all), X /= <<"">>],
  Result = count(List),
  io:fwrite("~p~n", [Result]);

main(["2"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [binary_to_integer(X) || X <- string:split(Input, "\n", all), X /= <<"">>],
  Result = count3(List),
  io:fwrite("~p~n", [Result]).
