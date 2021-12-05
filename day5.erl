-module(day5).
-export([main/1]).
-mode(compile).
 -define(INPUT, <<"input/day5">>).
%-define(INPUT, <<"input/day5_sample">>).

get_seq(A,B) when A > B -> lists:seq(A,B,-1);
get_seq(A,B) -> lists:seq(A,B).

count([]) -> 0;
count(X) ->
  {A,B} = lists:splitwith(fun (P) -> P =:= hd(X) end, X),
  if length(A) > 1 -> 1;
     true -> 0
  end + count(B).

point_line({{X,Y1},{X,Y2}}) ->
  [{X,Y} || Y <- get_seq(Y1,Y2)];
point_line({{X1,Y},{X2,Y}}) ->
  [{X,Y} || X <- get_seq(X1,X2)];
point_line({{X1,Y1},{X2,Y2}}) ->
  [{X,Y} || {X,Y} <- lists:zip(get_seq(X1,X2), get_seq(Y1,Y2))].

parse_line(Line) ->
  [[X1,Y1],[X2,Y2]] = [[binary_to_integer(X) || X <- string:split(P, ",")] || P <- string:split(Line, " -> ")],
  {{X1,Y1},{X2,Y2}}.
get_input() ->
  {ok, Input} = file:read_file(?INPUT),
  [parse_line(X) || X <- string:split(Input, "\n", all), X =/= <<"">>].

main(["1"]) ->
  Input = get_input(),
  Start = erlang:monotonic_time(nanosecond),
  Result = count(lists:sort(lists:flatten([point_line(P) || P={{X1,Y1},{X2,Y2}} <- Input, X1=:=X2 orelse Y1 =:= Y2]))),
  End = erlang:monotonic_time(nanosecond),
  io:fwrite("Part 1: ~p~nTook: ~p~n", [Result, (End - Start) / 1000000000]);
main(["2"]) ->
Input = get_input(),
Start = erlang:system_time(nanosecond),
Result = count(lists:sort(lists:flatten([point_line(P) || P <- Input]))),
End = erlang:system_time(nanosecond),
io:fwrite("Part 1: ~p~nTook: ~p~n", [Result, (End - Start) / 1000000000]).