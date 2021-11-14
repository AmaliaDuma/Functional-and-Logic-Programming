%a. Write a predicate to compute the intersection of two sets.

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
 *  set_intersect(l1..ln,a1..am) = [], if n=0
 *                               = l1 U set_intersect(l2..ln,a1..am), if nr_oc(a1..am,l1)=1
 *                               = set_intersect(l2..ln,a1..am), otherwise
 * Documentation:
 *  set_intersect(L-set1,L2-set2,R-resulted set)
 *  flow model: (i,i,i), (i,i,o)
 */

set_intersect([],_,[]).
set_intersect([H|T],L2,[H|R]):-
    nr_oc(L2,H,Oc),
    Oc =:= 1,!,
    set_intersect(T,L2,R).
set_intersect([_|T],L2,R):-
    set_intersect(T,L2,R).


% b. Write a predicate to create a list (m, ..., n) of all integer
% numbers from the interval[m, n].

/* Mathematical model:
 *  gen_interval(m,n) = [], if m>n
 *                    = m U gen_interval(m+1,n), otherwise
 * Documentation:
 *  gen_interval(M-number;N-number;R-resulted list)
 *  flow model: (i,i,i), (i,i,o)
 */

gen_interval(M,N,[]):-M>N,!.
gen_interval(M,N,[M|R]):-
    M1 is M+1,
    gen_interval(M1,N,R).
