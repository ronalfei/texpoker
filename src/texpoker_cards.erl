-module(texpoker_cards).
-include("texpoker.hrl").

-compile(export_all).


card(1)  -> {?S, "e"};
card(2)  -> {?S, "2"};
card(3)  -> {?S, "3"};
card(4)  -> {?S, "4"};
card(5)  -> {?S, "5"};
card(6)  -> {?S, "6"};
card(7)  -> {?S, "7"};
card(8)  -> {?S, "8"};
card(9)  -> {?S, "9"};
card(10) -> {?S, "a"};
card(11) -> {?S, "b"};
card(12) -> {?S, "c"};
card(13) -> {?S, "d"};

card(14) -> {?H, "e"};
card(15) -> {?H, "2"};
card(16) -> {?H, "3"};
card(17) -> {?H, "4"};
card(18) -> {?H, "5"};
card(19) -> {?H, "6"};
card(20) -> {?H, "7"};
card(21) -> {?H, "8"};
card(22) -> {?H, "9"};
card(23) -> {?H, "a"};
card(24) -> {?H, "b"};
card(25) -> {?H, "c"};
card(26) -> {?H, "d"};

card(27) -> {?C, "e"};
card(28) -> {?C, "2"};
card(29) -> {?C, "3"};
card(30) -> {?C, "4"};
card(31) -> {?C, "5"};
card(32) -> {?C, "6"};
card(33) -> {?C, "7"};
card(34) -> {?C, "8"};
card(35) -> {?C, "9"};
card(36) -> {?C, "a"};
card(37) -> {?C, "b"};
card(38) -> {?C, "c"};
card(39) -> {?C, "d"};

card(40) -> {?D, "e"};
card(41) -> {?D, "2"};
card(42) -> {?D, "3"};
card(43) -> {?D, "4"};
card(44) -> {?D, "5"};
card(45) -> {?D, "6"};
card(46) -> {?D, "7"};
card(47) -> {?D, "8"};
card(48) -> {?D, "9"};
card(49) -> {?D, "a"};
card(50) -> {?D, "b"};
card(51) -> {?D, "c"};
card(52) -> {?D, "d"}.
