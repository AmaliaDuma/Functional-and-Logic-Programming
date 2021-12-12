%a. Write a predicate to remove all occurrences of a certain atom from a list.

/* Mathematical model:
 *  remove(l1l2...ln,e) = [], if n=0
 *                      = remove(l2...ln,e), if l1=e
 *                      = l1 U remove(l2...ln,e), otherwise
 * Documentation:
 *  remove(L-initial list, E-number, R-resulted list)
 *  flow model: (i,i,i), (i,i,o)
 */
 
remove([],_,[]).
remove([E|T],E,R):-!,
    remove(T,E,R).
remove([H|T],E,R):-
    remove(T,E,R1),
    R = [H|R1].


% b. Define a predicate to produce a list of pairs (atom n) from an initial list of atoms. In this initial list atom has n occurrences.
% numberatom([1, 2, 1, 2, 1, 3, 1], X) => X =[[1, 4], [2, 2], [3, 1]].

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
 *  numberatom(l1l2..ln) = [], in n=0
 *                       = [l1, nr_oc(l1l2..ln,l1)] U numberatom(remove(l2..ln,l1)), otherwise
 * Documentation:
 *  numberatom(L-initial list, R-resulted list)
 *  flow model: (i,i), (i,o)
 */

numberatom([],[]).
numberatom([H|T],[[H,HC]|R]):-
    nr_oc([H|T],H,HC),
    remove(T,H,L),
    numberatom(L,R).
