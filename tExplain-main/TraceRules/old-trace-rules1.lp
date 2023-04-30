locationB(A,B,C) :- location(A,B,C).
%!trace {"% was at % during sentence %", O', S', B} locationB(O, S, B) : is_a(O, O'), is_a(S, S').
%!trace {"% % % at time point %", X0', A, B', X2} happened(X1,X2) : is_a(X1, X1'), event_agent(X1, X0), is_a(X0, X0'), link(X1', A), actions_vn_destination(X1,B), is_a(B, B').
%!show_trace locationB(O_G,D_G,VAR_0).