find_sim_1(X, Y):- genre(X, G1), genre(Y, G1), X \= Y.

find_sim_2(X, Y):-
    genre(X,A),
    genre(Y,A),
    genre(X,B),
    genre(Y,B), 
    X\=Y, A\=B.

/*comparing genres*/

common_genre(X,Y,G):- genre(X,G), genre(Y,G), X\=Y.

find_genre_sim(X,Y,L):-
    setof(G, common_genre(X,Y,G), B),
    list_to_set(B,S),
    length(S,L1),
    L is L1.

strongly_common_subject(X,Y,L):-
    find_genre_sim(X,Y,L),
    @>=(L,5).

common_subject(X,Y,L):-
    find_genre_sim(X,Y,L),
    @>=(L,3).

weakly_common_subject(X,Y,L):-
    find_genre_sim(X,Y,L),
    @>=(L,1).

/*comparing plots*/
common_plot_keyword(X,Y,K):- plot_keyword(X,K), plot_keyword(Y,K), X\=Y.

find_plot_sim(X,Y,L):-
    setof(K, common_plot_keyword(X,Y,K), B),
    list_to_set(B,S),
    length(S,L1),
    L is L1.

identical_plot(X,Y,S):-
    find_plot_sim(X,Y,S),
    @>=(S,3).

similar_plot(X,Y,S):-
    find_plot_sim(X,Y,S),
    @>=(S,1).

/*comparing directors*/
common_director(X,Y):- director(X,A), director(Y,A), X\=Y.

/*comparing actors*/
actor(X,A):- actor_1(X,A).
actor(X,A):- actor_2(X,A).
actor(X,A):- actor_3(X,A).

common_actor_N(_,_,[],0):-!.

common_actor_N(X,Y,[A|Tail],N):-
    actor(X,A),
    actor(Y,A),
    N_new is N-1,
    X\=Y,
    common_actor_N(X,Y,Tail,N_new),
    \+member(A,Tail).

common_actor(X,N,S):-
    setof(Y, common_actor_N(X,Y,_,N), S),
    !.

/*comparing languages*/

common_language_N(_,_,[],0):-!.

common_language_N(X,Y,[A|Tail],N):-
    language(X,A),
    language(Y,A),
    N_new is N-1,
    X\=Y,
    common_language_N(X,Y,Tail,N_new),
    \+member(A,Tail).

common_language(X,N,S):-
    setof(Y,common_language_N(X,Y,_,N), S),
    !.

/*comparing production companies*/
find_common_company(X,Y,C):-
    production_company(X,C),
    production_company(Y,C),
    X\=Y.

common_company(X,S):-
    setof(Y, find_common_company(X,Y,_), S),
    !.

/*comparing countries*/
% find_common_country(X,Y,C):-
%     production_country(X,C),
%     production_country(Y,C),
%     X \= Y.

common_country_N(_,_,[],0):-!.

common_country_N(X,Y,[A|Tail],N):-
    production_country(X,A),
    production_country(Y,A),
    X\=Y,
    N_new is N-1,
    common_country_N(X,Y,Tail,N_new),
    \+member(A,Tail).

common_country(X,N,S):-
    setof(Y, common_country_N(X,Y,_,N), S),
    !.

/*common production decade*/
diff_under_10(A,B):-
    atom_number(A,N),
    atom_number(B,M),
    C is abs(N-M),
    =<(C,10).

find_same_decade(X,Y,A,B):-
    year(X,A),
    year(Y,B),
    diff_under_10(A,B).

same_dacade(X,S):-
    setof(Y, find_same_decade(X,Y,_,_), S),
    !.








