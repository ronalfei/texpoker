-module(texpoker_rate).
-include("texpoker.hrl").
-compile(export_all).

-define(FOR(N, M, F) , texpoker_util:for(N, M, F)).


rate_aa(N, M) -> 
	?FOR(N, M,
		fun(A) -> ?FOR(A+1, M,
			fun(B) -> ?FOR(B+1, M,
				fun(C) -> ?FOR(C+1, M,
					fun(D) -> ?FOR(D+1, M,
						fun(E) -> ?FOR(E+1, M,
							fun(F) -> ?FOR(F+1, M,
								fun(G) -> ?FOR(G+1, M,
									fun(H) -> 
										lager:info("A:~p | B:~p | C:~p | D:~p | E:~p | F:~p | G:~p | H:~p",[A,B,C,D,E,F,G,H])
									end
								) end
							) end
						) end
					) end
				) end
			) end
		) end
	).





%%----internal function ----------------



%%--------------test function 
test() -> 
	rate_aa(1, 52).
