-module(day1).
-export([main/1]).
-mode(compile).
-define(INPUT, <<"input/day3">>).
%-define(INPUT, <<"input/day3_sample">>).

%% Part 1 %%
addA(<<$1:8, Tl/binary>>) -> [{1,0}|addA(Tl)];
addA(<<$0:8, Tl/binary>>) -> [{0,1}|addA(Tl)];
addA(<<>>) -> [].

get_cnt([X]) -> addA(X);
get_cnt([Hd|Tl]) ->
 X = get_cnt(Tl),
 [{A+B,C+D} || {{A,C},{B,D}} <- lists:zip(X, addA(Hd))].

invert([$1|Tl]) -> [$0|invert(Tl)];
invert([$0|Tl]) -> [$1|invert(Tl)];
invert([]) -> [].

part1(List) ->
  L = get_cnt(List),
  X = [if A>B -> $1; true -> $0 end || {A,B} <- L],
  list_to_integer(X, 2) * list_to_integer(invert(X), 2).

%% Part 2 %%
get_most_common([{<<Hd:8,_/binary>>, _}|Tl]) -> Hd - $0 + get_most_common(Tl);
get_most_common([]) -> 0.

btail(<<_:8,Tl/binary>>) -> Tl.

part2([{_,X}], _) -> binary_to_integer(X, 2);
part2(Mc, Fun) ->
  X = Fun(get_most_common(Mc), length(Mc) / 2),
  part2([{btail(A1), A2} || {A1,A2} <- Mc, (binary:first(A1) =:= $1) =:= X], Fun).

main(["1"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [X || X <- string:split(Input, "\n", all), X /= <<"">>],
  io:fwrite("~p~n", [part1(List)]);

main(["2"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [{X,X} || X <- string:split(Input, "\n", all), X /= <<"">>],
  A = part2(List, fun erlang:'>='/2),
  B = part2(List, fun erlang:'<'/2),
  io:fwrite("~p,~p~n~p~n", [A,B,A*B]).

