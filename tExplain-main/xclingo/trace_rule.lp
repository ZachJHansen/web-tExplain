%%%%%% Indirect effects
%!trace_rule {"The relay is working at %",J}
c(relay,on,J) :- h(s1,closed,J), h(ab(relay),false,J), time(J).

%!trace_rule {"The relay is not working at %",J}
    c(relay,off,J) :- h(s1,open,J), time(J).

%!trace_rule {"The relay is not working at %",J}
    c(relay,off,J) :- h(ab(relay),true,J), time(J).

 c(s2,closed,J) :- h(relay,on,J), time(J).

%!trace_rule {"The light is on at %",J}
    c(light,on,J) :- h(s2,closed,J), h(ab(bulb),false,J), time(J).

%!trace_rule {"The light is off at %",J}
    c(light,off,J):- h(s2,open,J), time(J).

%!trace_rule {"The light is off at %",J}
    c(light,off,J) :- h(ab(bulb),true ,J), time(J).

%%%%%% Malfunctioning
%!trace_rule {"The bulb has been damaged at %",I}
    c(ab(bulb),true ,I) :- o(break ,I), step(I).
    
%!trace_rule {"The relay has been damaged at %",I}
    c(ab(relay),true,I) :- o(surge,I), step(I).

%!trace_rule {"The bulb has been damaged at %",I}
    c(ab(bulb),true,I) :- o(surge,I), not h(b_prot,true,I-1), step(I).