-module(day1).
-export([main/1]).
-mode(compile).
 -define(INPUT, <<"input/day3">>).
%-define(INPUT, <<"input/day3_sample">>).

addA(<<$1:8, Tl/binary>>) -> [{1,0}|addA(Tl)];
addA(<<$0:8, Tl/binary>>) -> [{0,1}|addA(Tl)];
addA(<<>>) -> [].

get_cnt([X]) -> addA(X);
get_cnt([Hd|Tl]) ->
 X = get_cnt(Tl),
 [{A+B,C+D} || {{A,C},{B,D}} <- lists:zip(X, addA(Hd))].

invert(<<$1:8,Tl/binary>>) -> <<$0, (invert(Tl))/binary>>;
invert(<<$0:8,Tl/binary>>) -> <<$1, (invert(Tl))/binary>>;
invert(<<>>) -> <<>>.

part1(List) ->
  L = get_cnt(List),
  X = list_to_binary([if A>B -> $1; true -> $0 end || {A,B} <- L]),
  toint(X) * toint(invert(X)).

get_most_common([{<<Hd:8,_/binary>>, _}|Tl]) -> Hd - $0 + get_most_common(Tl);
get_most_common([]) -> 0.

toint(<<>>) -> 0;
toint(X) ->
  <<Hd:(byte_size(X)-1)/binary,Y:8>> = X,
  (toint(Hd) bsl 1) + (Y band 1).

part2([{_,X}], _) -> toint(X);
part2(Mc, Fun) ->
  X = Fun(get_most_common(Mc), length(Mc) / 2),
  part2([{binary:last(A1), A2} || {A1,A2} <- Mc, (binary:first(A1) =:= $1) =:= X], Fun).

main(["1"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [X || X <- string:split(Input, "\n", all), X /= <<"">>],
  io:fwrite("~p~n", [part1(List)]);

main(["2"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [{X,X} || X <- string:split(Input, "\n", all), X /= <<"">>],
  A = part2(List, fun erlang:'>='/2),
  B = part2(List, fun erlang:'<'/2),
  io:fwrite("~p~n", [A*B]).

