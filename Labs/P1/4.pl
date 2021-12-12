% a. Write a predicate to determine the difference of two sets.

/* Mathematical model:
 *  nr_oc(l1l2...ln,e) = 0, if n=0
 *                     = 1 + nr_oc(l2..ln,e), if l1=e
 *                     = nr_oc(l2...ln,e), otherwise
 * Documentation:
 *  nr_oc(L-initial list, E-number, R-resulted nr)
 *  flow model: (i,i,i),(i,i,o)
 */
nr_oc([],_,0).
nr_oc([E|T],E,R):-!,
    nr_oc(T,E,R1),
    R is R1+1.
nr_oc([_|T],E,R):-
    nr_oc(T,E,R).


/* Mathematical model:
 *  diff_set(l1l2..ln, a1a2..am) = [], if n=0
 *                               = l1 U diff_set(l2..ln,a1..am), if nr_oc(a1..am,l1) = 0
 *                               = diff_set(l2..ln,a1..am), oterwise
 * Documentation:
 *  diff_set(L-first list, L2-second list, R-resulted set difference)
 *  flow model: (i,i,i), (i,i,o)
 */
 
diff_set([],_,[]).
diff_set([H|T],L2,[H|R]):-
    nr_oc(L2,H,HC),
    HC =:= 0,
    diff_set(T,L2,R).
diff_set([H|T],L2,R):-
    nr_oc(L2,H,HC),
    HC > 0,
    diff_set(T,L2,R).


% b. Write a predicate to add value 1 after every even element from a list.

/* Mathematical model:
 *  add_after_even(l1l2..ln) = [], if n=0
 *                           = l1 U 1 U add_after_even(l2..ln), if l1 mod 2 = 0
 *                           = l1 U add_after_even(l2..ln), otherwise
 * Documentation:
 *  add_after_even(L-initial list, R-resulted list)
 *  flow model: (i,i), (i,o)
 */
 
add_after_even([],[]).
add_after_even([H|T],[H,1|R]):-
    H mod 2 =:= 0,!,
    add_after_even(T,R).
add_after_even([H|T],[H|R]):-
    add_after_even(T,R).
