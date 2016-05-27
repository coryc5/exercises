%%%-------------------------------------------------------------------
%%% @author Cory
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. May 2016 2:32 PM
%%%-------------------------------------------------------------------
-module(sequential).
-author("Cory").

%% API
-compile(export_all).

sum(N) when N > 0 -> sum(N, 0);
sum(_) -> 0.

sum(1, Acc) -> Acc + 1;
sum(N, Acc) -> sum(N - 1, Acc + N).

sum_interval(A, B) when A =< B -> sum_interval(A, B, 0);
sum_interval(_, _) -> 0.

sum_interval(X, X, Acc) -> Acc + X;
sum_interval(A, B, Acc) -> sum_interval(A + 1, B, Acc + A).

create(N) -> create(N, []).

create(1, Acc) -> [1 | Acc];
create(N, Acc) -> create(N - 1, [N | Acc]).

reverse_create(N) -> reverse_create(N, 1, []).

reverse_create(N, N, Acc) -> [N|Acc];
reverse_create(N, A, Acc) -> reverse_create(N, A + 1, [A | Acc]).

print(N) -> print(N, 1).

print(N, N) -> io:format("~p~n", [N]);
print(N, Acc) ->
  io:format("~p~n", [Acc]),
  print(N, Acc + 1).

even_print(N) -> even_print(N, 1).

even_print(N, N) when N rem 2 =:= 0 -> io:format("~p~n", [N]);
even_print(N, N) -> ok;
even_print(N, Acc) when Acc rem 2 =:= 0 ->
  io:format("~p~n", [Acc]),
  even_print(N, Acc + 1);
even_print(N, Acc) -> even_print(N, Acc + 1).
