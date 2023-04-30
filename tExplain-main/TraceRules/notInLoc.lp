locationB(A,B,C) :- location(A,B,C).

notInLocation(A,B,C) :- -location(A,B,C).

top_concept(move).
top_concept(obtain).
link_r(X,X'):-link(X,X').
link_r(X,X'):-link_r(X,X1),link(X1,X').
event_top_concept(E,C):-link_r(E,C),top_concept(C).

%!trace {"% is located at % in sentence %", O', S', B} locationB(O, S, B) : is_a(O, O'), is_a(S, S').
%!trace {"% is not located at % in sentence %", O', S', B} notInLocation(O, S, B) : is_a(O, O'), is_a(S, S').
%!trace {"% %d to % in sentence %", X0', A, B', X2 + 1} happened(X1,X2) : is_a(X1, X1'), event_agent(X1, X0), is_a(X0, X0'), event_top_concept(X1', A), actions_vn_destination(X1,B), is_a(B, B').
%!trace {"% %d to % in sentence %", X0', A, B', X2 + 1} happened(X1,X2) : is_a(X1, X1'), event_agent(X1, X0), is_a(X0, X0'), event_top_concept(X1', A), actions_vn_location(X1,B), is_a(B, B').
%!trace {"Since % %ed the % in sentence %", X0', A, B', X2 + 1} happened(X1,X2) : is_a(X1, X1'), event_recipient(X1, X0), event_object(X1, B), is_a(X0, X0'), event_top_concept(X1', A), is_a(B, B').


%!show_trace notInLocation(O_G,D_G,VAR_0).