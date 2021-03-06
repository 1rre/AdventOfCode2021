-module(day1).
-export([main/1]).
-mode(compile).
-define(INPUT, <<"input/day2">>).

add_tuple({A,B}, {C,D}) -> {A+C, B+D}.

part1([{forward, N}|Tl]) -> add_tuple({N,0}, part1(Tl));
part1([{down, N}|Tl]) -> add_tuple({0,N}, part1(Tl));
part1([{up, N}|Tl]) -> add_tuple({0,-N}, part1(Tl));
part1([]) -> {0,0}.

part2([{forward, N}|Tl], A) ->add_tuple({N,N*A}, part2(Tl, A));
part2([{down, N}|Tl], A) -> part2(Tl, A+N);
part2([{up, N}|Tl], A) -> part2(Tl, A-N);
part2([],_) -> {0,0}.


mkatom(Str) ->
  [Dir, N] = string:split(Str, " ", all),
  {binary_to_atom(Dir), binary_to_integer(N)}.

main(["1"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [mkatom(X) || X <- string:split(Input, "\n", all), X /= <<"">>],
  {A,B} = part1(List),
  io:fwrite("~p~n", [{A,B}]),
  io:fwrite("~p~n", [A*B]);

main(["2"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [mkatom(X) || X <- string:split(Input, "\n", all), X /= <<"">>],
  {A,B} = part2(List, 0),
  io:fwrite("~p~n", [{A,B}]),
  io:fwrite("~p~n", [A*B]).

