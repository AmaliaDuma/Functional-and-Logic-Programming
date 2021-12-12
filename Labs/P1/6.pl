% a. Write a predicate to test if a list is a set.

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
 *  check_set(l1l2...ln) = true, if n=0 or n=1
 *                       = false, if nr_oc(l2..ln,l1)!=0
 *                       = check_set(l2..ln), otherwise
 * Documentation:
 *  check_set(L-list to be checked)
 *  flow model: (i)
 */

check_set([]).
check_set([_]).
check_set([H|T]):-
    nr_oc(T,H,R),
    R =:= 0,
    check_set(T),!.


% b. Write a predicate to remove the first three occurrences of an element in a list. If the element occurs less than three times, all occurrences will be removed.

/* Mathematical model:
 *  remove_kOc(l1l2...ln,e,k) = [], if n=0
 *                            = l1l2..ln, if k=0
 *                            = remove_kOc(l2..ln,e,k-1), if l1=e
 *                            = l1 U remove_kOc(l2..ln,e,k), otherwise
 * Documentation:
 *  remove_kOc(L-initial list, E-number to be removed, K-occurences to delete;number, R-resulted list)
 *  flow model: (i,i,i,i), (i,i,i,o)
 */

remove_kOc([],_,_,[]).
remove_kOc(L,_,0,L).
remove_kOc([E|T],E,K,R):-!,
    K1 is K-1,
    remove_kOc(T,E,K1,R).
remove_kOc([H|T],E,K,[H|R]):-
    remove_kOc(T,E,K,R).


/* Mathematical model:
 *  remove_kOc_main(l1l2..ln,e) = remove_kOc(l1l2..ln,e,3)
 * Documentation:
 *  remove_kOc_main(L-initial list, E-number to be removed, R-resulted list)
 *  flow model: (i,i,i), (i,i,o)
 */
 
remove_kOc_main(L,E,R):-remove_kOc(L,E,3,R).
