%%%-------------------------------------------------------------------
%%% @author Cory
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. May 2016 3:20 PM
%%%-------------------------------------------------------------------
-module(db).
-author("Cory").

%% API
-compile(export_all).

new() -> [].

write(Key, Value, Db) ->
  case read(Key, Db) of
    {error, instance} ->
      reverse([{Key, Value} | reverse(Db)]);
    {ok, _} ->
      NewDb = delete(Key, Db),
      write(Key, Value, NewDb)
  end.

delete(Key, Db) -> delete(Key, Db, []).

delete(_Key, [], Acc) -> reverse(Acc);
delete(Key, [{Key1, _} | T], Acc) when Key =:= Key1 -> join(Acc, T);
delete(Key, [H | T], Acc) -> delete(Key, T, [H | Acc]).


read(_Key, []) -> {error, instance};
read(Key, [{Key1, Value1} | _]) when Key =:= Key1 -> {ok, Value1};
read(Key, [_H | T]) -> read(Key, T).

match(Value, Db) -> match(Value, Db, []).

match(_Value, [], Acc) -> reverse(Acc);
match(Value, [{Key1, Value1} | T], Acc) when Value =:= Value1 ->
  match(Value, T, [Key1 | Acc]);
match(Value, [_H | T], Acc) -> match(Value, T, Acc).

reverse(List) -> reverse(List, []).

reverse([], Acc) -> Acc;
reverse([H | T], Acc) -> reverse(T, [H | Acc]).

%% Does not fix reverse, and other functions rely on this behavior lol
%% join([1,2,3], [4]) -> [3,2,1,4].
join([], L) -> L;
join([H | T], L) -> join(T, [H | L]).

filter(List, N) -> [X || X <- List, X =< N].

concatenate(List) -> concatenate(List, []).

concatenate([], Acc) -> reverse(Acc);
concatenate([H| T], Acc) -> concatenate(T, join(H, Acc)).

flatten(List) -> flatten(List, []).

flatten([], Acc) -> reverse(Acc);
flatten([H | T], Acc) when is_list(H) -> flatten(T, join(flatten(H), Acc));
flatten([H | T], Acc) -> flatten(T, [H | Acc]).


%% seems like the real benefit of this one over the commented out version below
%% is that this one only traverses the list one time to sort between small\larger
%% but that portion isn't really doing any quicksorting. in the end, neither
%% perform the quicksort part tail recursively.
quicksort([]) -> [];
quicksort([Single]) -> [Single];
quicksort([H | T]) -> quicksort(H, T).

quicksort(Pivot, List) ->
  {Smaller, GreaterOrEqual} = quicksort(Pivot, [], [], List),
  SortedSmaller = quicksort(Smaller),
  SortedGreaterOrEqual = quicksort(GreaterOrEqual),
  SortedSmaller ++ [Pivot] ++ SortedGreaterOrEqual.

quicksort(_Pivot, Smaller, GreaterOrEqual, []) -> {Smaller, GreaterOrEqual};
quicksort(Pivot, Smaller, GreaterOrEqual, [H | T]) when H < Pivot ->
  quicksort(Pivot, [H | Smaller], GreaterOrEqual, T);
quicksort(Pivot, Smaller, GreaterOrEqual, [H | T]) when H >= Pivot ->
  quicksort(Pivot, Smaller, [H | GreaterOrEqual], T).

%% less efficient version
%%quicksort([H | T]) ->
%%  Pivot = H,
%%  Smaller = [X || X <- T, X =< Pivot],
%%  EqOrLarger = [X || X <- T, X > Pivot],
%%  quicksort(Smaller) ++ [Pivot] ++ quicksort(EqOrLarger).

find_list_length(List) -> find_list_length(List, 0).

find_list_length([], N) -> N;
find_list_length([_H | T], N) -> find_list_length(T, N + 1).

merge(L1, L2) -> merge(L1, L2, []).

merge([], L2, Acc) -> lists:append(lists:reverse(L2), Acc);
merge(L1, [], Acc) -> lists:append(lists:reverse(L1), Acc);
merge([H1 | T1], [H2 | T2], Acc) when H2 < H1 ->
  merge([H1 | T1], T2, [H2 | Acc]);
merge([H1 | T1], [H2 | T2], Acc) ->
  merge(T1, [H2 | T2], [H1 | Acc]).

mergesort([]) -> [];
mergesort([X]) -> [X];
mergesort(List) ->
  {L1, L2} = lists:split(trunc(length(List)/2), List),
  SortedL1 = mergesort(L1),
  SortedL2 = mergesort(L2),
  lists:reverse(merge(SortedL1, SortedL2)).


