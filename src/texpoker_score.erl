-module(texpoker_score).
-include("texpoker.hrl").

-compile(export_all).

% L=origin List
fetch(L) when length(L) == 7 ->
	case texpoker_flush:get_flush(L) of
		[] ->
			case texpoker_straight:get_straight(L) of
				[] -> 
					case texpoker_four:get_four(L) of
						[] ->
							case texpoker_three:get_three(L) of
								[] ->
									case texpoker_apair:get_apair(L) of
										[] ->
											calc_score(?TYPE_VALUE_HIGHC,texpoker_highc:get_hightc(L));
										L5 ->
											case texpoker_tpairs:get_tpairs(L) of
												[] -> calc_score(?TYPE_VALUE_APAIR, L5);
												L6 -> calc_score(?TYPE_VALUE_TPAIRS, L6)
											end
									end;
								L4 -> 	
									case texpoker_fhouse:get_fhouse(L) of 
										[] -> calc_score(?TYPE_VALUE_THREE,  L4); %% return three of a kind 
										L5 -> calc_score(?TYPE_VALUE_FHOUSE, L5)  %% return full house
									end
							end;
						L3 -> calc_score(?TYPE_VALUE_FOUR, L3)				%% return four of a kind
					end;
				L2 -> calc_score(?TYPE_VALUE_STRAIGHT, L2)					%% return straight
			end;
		L1 -> 
			case texpoker_straight:get_straight(L1) of
				[] -> calc_score(?TYPE_VALUE_FLUSH,  lists:sublist(L1,5));	%% reture flush
				L2 -> calc_score(?TYPE_VALUE_SFLUSH, L2)					%% return straight flush
			end
	end.





%%------internal function -----------
calc_score(Type, L) ->
	Score = lists:flatten([Type | texpoker_util:get_values(L)]),
	[{type, Type}, {score, Score}, {cards, L}].


%%------------- test ----------

test() ->
	L1 = [{"spade","b"},{"heart","a"},{"diamond","7"},{"club","b"},{"club","9"},{"heart","7"},{"spade","5"}],
	?dbg2("L1: ~p ", [L1]),
	A = ?MODULE:fetch(L1),
	?dbg2("test for L1 : ~p",[A]),
	L2 = [{"spade","2"},{"heart","a"},{"diamond","4"},{"club","e"},{"club","9"},{"heart","9"},{"spade","a"}],
	?dbg2("L1: ~p ", [L2]),
	B = ?MODULE:fetch(L2),
	?dbg2("test for L2 : ~p",[B]).
