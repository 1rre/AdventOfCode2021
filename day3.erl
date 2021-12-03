-module(day1).
-export([main/1]).
-mode(compile).
 -define(INPUT, <<"input/day3">>).
%-define(INPUT, <<"input/day3_sample">>).

addA(<<$1:8, Tl/binary>>) -> [{1,0}|addA(Tl)];
addA(<<$0:8, Tl/binary>>) -> [{0,1}|addA(Tl)];
addA(<<>>) -> [].

part1([X]) -> addA(X);
part1([Hd|Tl]) ->
 X = part1(Tl),
 [{A+B,C+D} || {{A,C},{B,D}} <- lists:zip(X, addA(Hd))].

resolve1([]) -> {<<>>, <<>>};
resolve1([{_A,_B}|Tl]) when _A > _B ->
  {X, Y} = resolve1(Tl),
  {<<1:1, X:(bit_size(X))/bits>>, <<0:1, Y:(bit_size(Y))/bits>>};
resolve1([_|Tl]) ->
  {X, Y} = resolve1(Tl),
  {<<0:1, X:(bit_size(X))/bits>>, <<1:1, Y:(bit_size(Y))/bits>>}.

get_most_common([{<<$1:8,_/binary>>, _}|Tl]) ->
  {A,B} = get_most_common(Tl),
  {1+A,B};
get_most_common([{<<$0:8,_/binary>>, _}|Tl]) ->
  {A,B} = get_most_common(Tl),
  {A,B+1};
get_most_common([]) -> {0,0}.

fp(<<X:8,_/binary>>) -> X.
lp(<<_:8,X/binary>>) -> X.

filter_most(X, {_A,_B}) when _A >= _B ->
  [{lp(A1), A2} || {A1,A2} <- X, fp(A1) =:= $1];
filter_most(X, {_A,_B}) ->
  [{lp(A1), A2} || {A1,A2} <- X, fp(A1) =:= $0].

filter_least(X, {_A,_B}) when _A < _B ->
  [{lp(A1), A2} || {A1,A2} <- X, fp(A1) =:= $1];
filter_least(X, {_A,_B}) ->
  [{lp(A1), A2} || {A1,A2} <- X, fp(A1) =:= $0].

co2([{_,X}]) -> X;
co2(Mc) ->
  {M1,M2} = get_most_common(Mc),
  co2(filter_least(Mc, {M1, M2})).

oxy([{_,X}]) -> X;
oxy(Mc) ->
  {M1,M2} = get_most_common(Mc),
  oxy(filter_most(Mc, {M1, M2})).

toint(<<$1:8,Tl/binary>>) -> <<1:1,(toint(Tl))/bits>>;
toint(<<$0:8,Tl/binary>>) -> <<0:1,(toint(Tl))/bits>>;
toint(<<>>) -> <<>>.

main(["1"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [X || X <- string:split(Input, "\n", all), X /= <<"">>],
  X = part1(List),
  {C,D} = resolve1(X),
  <<A:(bit_size(C))>> = C,
  <<B:(bit_size(D))>> = D,
  io:fwrite("~p~n", [A*B]);

main(["2"]) ->
  {ok, Input} = file:read_file(?INPUT),
  List = [{X,X} || X <- string:split(Input, "\n", all), X /= <<"">>],
  C = toint(oxy(List)),
  D = toint(co2(List)),
  <<A:(bit_size(C))>> = C,
  <<B:(bit_size(D))>> = D,
  io:fwrite("~p~n", [A*B]).

