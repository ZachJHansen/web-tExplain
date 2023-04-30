locationB(A,B,C) :- location(A,B,C).

location_mapping(Oref,T2,T2+N+1) :- location(Oref,X2,T2), Q = #max{Q' : nquery(Q',N'),
    T2 > Q'-N'}, nquery(Q,N).

time_point(T) :- location(Oref,X2,T).
time_point(T) :- happened(E,T).

mapping(T2,T2+N+1) :- time_point(T2), Q = #max{Q' : nquery(Q',N'),
    T2 >= Q'-N'}, nquery(Q,N).

happened_mapping(T2,T2+N+1) :- happened(X1,T2), Q = #max{Q' : nquery(Q',N'),
    T2 >= Q'-N'}, nquery(Q,N).

nquery(Q,N-1) :- query(Q), N = #count{X: query(X), X <= Q}.

notInLocation(Oname,Lname,T2,T) :- 
    is_a(Oref,Oname), 
    is_aB(Lref,Lname), 
    location(Oref,Lref',T), 
    Lref!=Lref', 
    not is_a(Lref',Lname),
    mapping(T,T2).
    % location_mapping(Oref,T,T2).
    % most_recent(T2).

inLocation(Oname,Lname,T2,T) :- 
    is_a(Oref,Oname), 
    is_a(Lref,Lname), 
    location(Oref,Lref,T),
    mapping(T,T2).
    % location_mapping(Oref,T,T2).
    % most_recent(T2).

%!trace {"YES % is located at % in sentence %", O, S, T} inLocation(O, S, B, T).
%!trace {"NO  % is not located at % in sentence %", O, S, T} notInLocation(O, S, B, T).

numberObjectsbyEntityatTime(N,Ename,T):- 
    N=#count{O: held_by(O,Eref,T)}, 
    timeStep(T), 
    living_entity(Eref), 
    is_a(Eref,Ename).

entityCarrying(Lname,Ename,T) :- 
    held_by(Lref,Eref,T), 
    living_entity(Eref), 
    timeStep(T), 
    is_a(Eref,Ename), 
    is_a(Lref,Lname).

entityNotCarrying(Lname,Ename,T) :- 
    -held_by(Lref,Eref,T), 
    living_entity(Eref), 
    timeStep(T), 
    is_a(Eref,Ename), 
    is_a(Lref,Lname),
    not entityCarryingSomething(Ename,T).

entityCarryingSomething(Ename,T) :- entityCarrying(Lname,Ename,T).



#show entityNotCarrying/3.
#show entityCarrying/3.
%!trace {"% is holding nothing", E} entityNotCarrying(L,E,T).
%!trace {"% is holding %", E,L} entityCarrying(L,E,T).
% !show_trace entityCarrying(L,E,T).

must_possesses(D_G,O_G,TS_G) :- 
    event_donor(X_G,D_G),
    event_object(X_G,O_G),
    occurs(X_G,TS_G),
    instance(X_G,transfer),
    entity(O_G),universe(X_G),
    entity(D_G),event(X_G),
    timeStep(TS_G),
    actions(X_G).

must_possesses(X0_G,X1_G,VAR_0) :-
    must_possesses(X0_G,X1_G,I_G),
    not -possesses(X0_G,X1_G,VAR_0),
    dom_possesses(X0_G,X1_G,VAR_0),
    VAR_0=I_G-1,
    entity(X0_G),
    entity(X1_G),
    timeStep(I_G),
    timeStep(VAR_0),
    not takes(X0_G,X1_G,VAR_0).
    
takes(D_G,O_G,VAR_0) :-
    event_recipient(X_G,D_G),
    event_object(X_G,O_G),
    occurs(X_G,VAR_0),
    timeStep(VAR_0),
    take_instance(X_G),
    entity(O_G),universe(X_G),
    entity(D_G),event(X_G).

take_instance(X_G) :- instance(X_G, obtain).
    
possesses(D_G,O_G,TS_G) :- must_possesses(D_G,O_G,TS_G).

% possesses(D_G,O_G,TS_G) :- must_possesses(D_G,O_G,TS_G).

% must_possesses(X0_G,X1_G,VAR_0) :-
%     must_possesses(X0_G,X1_G,I_G),
%     not -possesses(X0_G,X1_G,VAR_0),
%     VAR_0=I_G-1,
%     entity(X0_G),
%     entity(X1_G),
%     timeStep(I_G),
%     timeStep(VAR_0).

% !trace {"happened(%,%)", A', B} happened(A,B) : is_a(A,A').
% !trace {"possesses(D_G,O_G,TS_G)"} : possesses(D_G,O_G,TS_G).


top_concept(move).
top_concept(obtain).
% top_concept(relinquish).
top_concept(dropp).
link(lose,dropp).
link_r(X,X'):-link(X,X').
link_r(X,X'):-link_r(X,X1),link(X1,X').
event_top_concept(E,C):-link_r(E,C),top_concept(C).

changeLoc(Oname, L1name, L2name, T) :- 
    is_a(Oref,Oname),
    is_a(L1ref, L1name),
    is_a(L2ref, L2name), 
    changeLocAux(Oref, L1ref, L2ref, T).

changeLocAux(Oref, L1ref, L2ref, T) :- 
    locationB(Oref, L1ref, T-1), 
    locationB(Oref, L2ref, T), 
    L1ref != L2ref.

lastChangeLocAux(Oref, L1ref, L2ref, T) :-
    changeLocAux(Oref, L1ref, L2ref, T), T = #max{X: changeLocAux(Oref, _, L2ref, X)}.

lastChangeLoc(Oname, L1name, L2name,T2) :- 
    is_a(Oref,Oname),
    is_a(L1ref, L1name),
    is_a(L2ref, L2name), 
    lastChangeLocAux(Oref, L1ref, L2ref, T2),
    mapping(T,T2).
    % query(X1), % this is for some xclingo bug
    % T3 = #count{X: query(X), X < T2},
    % T = T2+T3-1.

% !show_trace changeLoc(N, M, O, T).

% !show_trace lastChangeLoc(football, L1, bathroom, T).
locationT2(Oname,L,T) :- 
    is_a(Oref,Oname), location(Oref,L,T).

% !show_trace locationT2(ball,S,3).

%!trace {"% is holding % items at time point %", E, N, T} numberObjectsbyEntityatTime(N,E,T).


trace_actions_vn_destination(X1, T2, X0', A, B', T3) :- 
    happened(X1,T2),
    mapping(T2,T3),
    is_a(X1, X1'),
    event_agent(X1, X0),
    is_a(X0, X0'),
    event_top_concept(X1', A),
    actions_vn_destination(X1,B),
    is_a(B, B').

trace_actions_vn_location(X1, T2, X0', A, B', T3) :-
    happened(X1,T2),
    mapping(T2,T3),
    is_a(X1, X1'), 
    event_agent(X1, X0), 
    is_a(X0, X0'), 
    event_top_concept(X1', A), 
    actions_vn_location(X1,B), 
    is_a(B, B').

trace_event_recipient(X1, T2, X0', A, B', T3) :-
    happened(X1,T2),
    mapping(T2,T3),
    is_a(X1, X1'),
    event_recipient(X1, X0), 
    event_object(X1, B), 
    is_a(X0, X0'), 
    event_top_concept(X1', A), 
    is_a(B, B').

trace_event_donor(X1, T2, X0', A, B', T3) :-
    happened(X1,T2),
    mapping(T2,T3),
    is_a(X1, X1'),
    event_donor(X1, X0),
    event_object(X1, B),
    is_a(X0, X0'),
    event_top_concept(X1', A),
    is_a(B, B').


%!trace {"% %d to % in sentence %", X0', A, B', X3} happened(X1,X2) : trace_actions_vn_destination(X1, X2, X0', A, B', X3).
%!trace {"% %d to % in sentence %", X0', A, B', X3} happened(X1,X2) : trace_actions_vn_location(X1, X2, X0', A, B', X3).
%!trace {"since % %ed the % in sentence %", X0', A, B', X3} happened(X1,X2) : trace_event_recipient(X1, X2, X0', A, B', X3).
%!trace {"since % %ed the % in sentence %", X0', A, B', X3} happened(X1,X2) : trace_event_donor(X1, X2, X0', A, B', X3).


%!trace {"% is located at %", O, S'} locationT2(O, S, B) : is_a(S, S').

%!trace {"Location of % before % : %", O, L2, L1} lastChangeLoc(O, L1, L2, T).

%  !trace {"% is carrying % items in sentence %", E, N, T}

%!mute time_point(T).
%!mute dom_location(X,Y,Z).
%!mute dom_actions_vn_extent(X,Y).
%!mute dom_actions_vn_coagent(X,Y).
%!mute dom_event_beneficiary(X,Y).
%!mute dom_event_site(X,Y).
%!mute dom_actions_vn_initial_location(X,Y).
%!mute dom_event_origin(X,Y).
%!mute dom_event_donor(X,Y).
%!mute dom_actions_vn_destination(X,Y).
%!mute dom_actions_vn_experiencer(X,Y).
%!mute dom_actions_vn_causer(X,Y).
%!mute dom_event_base(X,Y).
%!mute dom_event_experiencer(X,Y).
%!mute dom_actions_vn_predicate(X,Y).
%!mute dom_event_toward(X,Y).
%!mute dom_actions_vn_source(X,Y).
%!mute dom_actions_vn_product(X,Y).
%!mute dom_event_object(X,Y).
%!mute dom_actions_vn_result(X,Y).
%!mute dom_event_destination(X,Y).
%!mute dom_actions_vn_time(X,Y).
%!mute dom_event_raw_material(X,Y).
%!mute dom_actions_vn_value(X,Y).
%!mute dom_event_path(X,Y).
%!mute dom_actions_vn_actor(X,Y).
%!mute dom_actions_vn_copatient(X,Y).
%!mute dom_actions_vn_initial_state(X,Y).
%!mute dom_actions_vn_cotheme(X,Y).
%!mute dom_actions_vn_theme(X,Y).
%!mute dom_actions_vn_agent(X,Y).
%!mute dom_actions_vn_reflexive(X,Y).
%!mute dom_actions_vn_beneficiary(X,Y).
%!mute dom_actions_vn_stimulus(X,Y).
%!mute dom_actions_vn_recipient(X,Y).
%!mute dom_event_recipient(X,Y).
%!mute dom_actions_vn_patient(X,Y).
%!mute dom_actions_vn_goal(X,Y).
%!mute dom_event_away_from(X,Y).
%!mute dom_event_instrument(X,Y).
%!mute dom_actions_vn_location(X,Y).
%!mute dom_actions_vn_material(X,Y).
%!mute dom_actions_vn_instrument(X,Y).
%!mute dom_actions_vn_trajectory(X,Y).
%!mute dom_event_agent(X,Y).
%!mute dom_actions_vn_cause(X,Y).
%!mute dom_actions_vn_asset(X,Y).
%!mute dom_actions_vn_pivot(X,Y).
%!mute dom_actions_vn_topic(X,Y).
%!mute dom_event_result(X,Y).
%!mute dom_actions_vn_attribute(X,Y).
%!mute dom_is_on(X,Y,Z).
%!mute dom_is_contained(X,Y).
%!mute dom_blocked_with(X,Y,Z).
%!mute dom_is_under(X,Y,Z).
%!mute dom_is_outside(X,Y,Z).
%!mute dom_shut_out_of(X,Y,Z).
%!mute dom_is_at(X,Y,Z).
%!mute dom_is_beside(X,Y,Z).
%!mute dom_is_restrained(X,Y).
%!mute dom_is_between(X,Y,Z).
%!mute dom_is_closed(X,Y).
%!mute dom_is_below(X,Y,Z).
%!mute dom_is_confined(X,Y).
%!mute dom_is_accessible(X,Y).
%!mute dom_encloses(X,Y,Z).
%!mute dom_is_opposite(X,Y,Z).
%!mute dom_is_blocked(X,Y).
%!mute dom_has_part(X,Y,Z).
%!mute dom_is_touching(X,Y,Z).
%!mute dom_contained_in(X,Y,Z).
%!mute dom_confined_to(X,Y,Z).
%!mute dom_is_known(X,Y).
%!mute dom_content(X,Y,Z).
%!mute dom_is_along(X,Y,Z).
%!mute dom_is_near(X,Y,Z).
%!mute dom_is_behind(X,Y,Z).
%!mute dom_accessible_to(X,Y,Z).
%!mute dom_is_held(X,Y).
%!mute dom_is_inside(X,Y,Z).
%!mute dom_is_over(X,Y,Z).
%!mute dom_is_above(X,Y,Z).
%!mute dom_abuts(X,Y,Z).
%!mute dom_known_to(X,Y,Z).
%!mute dom_held_by(X,Y,Z).
%!mute dom_is_in_front_of(X,Y,Z).
%!mute dom_possesses(X,Y,Z).

%!mute mapping(A,B).
%!mute happened_mapping(A,B).

query(0).