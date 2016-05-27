%%%-------------------------------------------------------------------
%%% @author Cory
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. May 2016 2:26 PM
%%%-------------------------------------------------------------------
-module(boolean).
-author("Cory").

%% API
-compile(export_all).

b_not(true) -> false;
b_not(false) -> true.

b_and(X, X) -> X;
b_and(_, _) -> false.

b_or(true, _) -> true;
b_or(_, _) -> false.