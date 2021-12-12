% a. Define a predicate to remove from a list all repetitive elements.

/* Mathematical model:
 *  nr_oc(l1l2...ln,e) = 0, if n=0
 *                     = 1 + nr_oc(l2..ln,e), if l1=e
 *                     = nr_oc(l2...ln,e), otherwise
 * Documentation:
 *  nr_oc(L-initial list, E-number, R-resulted numberr)
 *  flow model: (i,i,i),(i,i,o)
 */
 
nr_oc([],_,0).
nr_oc([E|T],E,R):-!,
    nr_oc(T,E,R1),
    R is R1+1.
nr_oc([_|T],E,R):-
    nr_oc(T,E,R).
    
    
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


/* Mathematical model:
 *  remove_rep(l1l2...ln) = [], if n=0
 *                        = remove_rep(remove(l1l2...ln,l1)), if nr_oc(l1l2...ln,l1) > 1
 *                        = l1 U remove_rep(l2...ln), otherwise (if nr_oc(l1l2...ln,l1) = 1)
 */
 
remove_rep([],[]).
remove_rep([H|T],R):-
    nr_oc([H|T],H,C),
    C > 1,!,
    remove([H|T],H,L),
    remove_rep(L,R).
remove_rep([H|T],[H|R]):-
    remove_rep(T,R).


% b. Remove all occurrence of a maximum value from a list on integer nr.

/* Mathematical model:
 *  max_nr(a,b) = a, if a>=b
 *              = b, otherwise (a<b)
 * Documentation:
 *  max_nr(A-number,B-number,R-resulted nr)
 *  flow model: (i,i,i), (i,i,o)
 */
 
max_nr(A,B,A):-A>=B.
max_nr(A,B,B):-B>A.


/* Mathematical model:
 *  maxim_list(l1l2...ln) = l1, if n=1
 *                        = max_nr(l1,maxim_list(l2...ln)), otherwise
 * Documentation:
 *  maxim_list(L-initial list, R-resulted max number)
 *  flow model: (i,i), (i,o)
 */
 
maxim_list([H],H).
maxim_list([H|T],R):-
    maxim_list(T,R1),
    max_nr(H,R1,R).


/* Mathematical model:
 *  remove_allMax(l1l2...ln) = remove(l1l2...ln, maxim_list(l1l2...ln))
 * Documentation:
 *  remove_allMax(L-initial list, R-resulted list)
 *  flow model: (i,i), (i,o)
 */
remove_allMax([],[]).
remove_allMax(L,R):-
    maxim_list(L,R1),
    remove(L,R1,R).
