-module(day1).
-export([main/1]).
-mode(compile).
-define(INPUT, <<"input/day2">>).


part1([{forward, N}|Tl]) ->
  {H,V} = part1(Tl),
  {H+N, V};
part1([{down, N}|Tl]) ->
  {H,V} = part1(Tl),
  {H, V+N};
part1([{up, N}|Tl]) ->
  {H,V} = part1(Tl),
  {H, V-N};
part1([]) -> {0,0}.

part2([{forward, N}|Tl], A) ->
  {H,V} = part2(Tl, A),
  {H+N, V+N*A};
part2([{down, N}|Tl], A) ->
  part2(Tl, A+N);
part2([{up, N}|Tl], A) ->
  part2(Tl, A-N);
part2([],_) -> {0,0}.


mkatom(Str) ->
  [Dir, N] = string:split(Str, " ", all),
  {binary_to_atom(Dir), binary_to_integer(N)}.

main(["1"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [mkatom(X) || X <- string:split(Input, "\n", all), X /= <<"">>],
  {A,B} = part1(List),
  io:fwrite("~p~n", [A*B]);

main(["2"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [mkatom(X) || X <- string:split(Input, "\n", all), X /= <<"">>],
  {A,B} = part2(List, 0),
  io:fwrite("~p~n", [A*B]).

