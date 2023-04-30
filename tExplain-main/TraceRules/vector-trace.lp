in(O,S,D,B,B+1) :- instance(O, tangible_entity), instance(S, spatial_entity), instance(D, spatial_entity), timeStep(B), S != D, location(O, S, B), location(O, D, B+1).
vector_edge(O,S,D,B,BP) :- in(O,S,D,B,BP), S!=D. 
vector_edge(O,S,D,B,E) :- vector_edge(O,S,SP,B,BP), vector_edge(O,SP,D,EP,E), EP > B, E > B, S!=D.
vector_edgeB(O,S,D,B,E) :- vector_edge(O,S,D,B,E).
%!trace {"% went from % to %", O', S', D'} vector_edgeB(O, S, D, B, E) : is_a(O, O'), is_a(S, S'), is_a(D, D'). 
%!trace {"% was at % during sentence %", O', S', B} location(O, S, B) : is_a(O, O'), is_a(S, S').
%!trace {"% % % at time point %", X0', A, B', X2} happened(X1,X2) : is_a(X1, X1'), event_agent(X1, X0), is_a(X0, X0'), link(X1', A), actions_vn_destination(X1,B), is_a(B, B').
%!trace {"% % % at time point %", B', A, X0', X2} happened(X1,X2) : is_a(X1, X1'), event_destination(X1, X0), is_a(X0, X0'), link(X1', A), actions_vn_theme(X1,B), is_a(B, B').
%!show_trace vector_edgeB(O, S, D, B, E).
