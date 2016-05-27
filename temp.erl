%%%-------------------------------------------------------------------
%%% @author Cory
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. May 2016 2:19 PM
%%%-------------------------------------------------------------------
-module(temp).
-author("Cory").

%% API
-compile(export_all).

c2f(C) -> C * (9 / 5) + 32.

f2c(F) -> (F - 32) * (5 / 9).

convert({c, Temperature}) -> {f, c2f(Temperature)};
convert({f, Temperature}) -> {c, f2c(Temperature)}.
