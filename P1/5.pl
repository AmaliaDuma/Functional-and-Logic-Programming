% a. Write a predicate to compute the union of two sets.

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
 *  sets_union(l1l2...ln,a1a2...am) = [], if n=0 and m=0
 *                                  = l1 U union(remove(l1..ln,l1),remove(a1..am,l1)), if n>0
 *                                  = union(a1..am,[]), otherwise
 * Documentation:
 *  sets_union(L-first list, L1-second list, R-resulted union)
 *  flow model: (i,i,i), (i,i,o)
 */
 
sets_union([],[],[]).
sets_union([H|T],L2,[H|R]):-
    remove([H|T],H,R1),
    remove(L2,H,R2),
    sets_union(R1,R2,R).
sets_union([],L2,R):-
    sets_union(L2,[],R).

% b. Write a predicate to determine the set of all the pairs of elements in a list. 
% Eg.:L = [a b c d] =>[[a b] [a c] [a d] [b c] [b d] [c d]].

/* Mathematical model:
 *  one_pair(l1l2...ln,k) = [], if k=0
 *                        = l1 U one_pair(l2..ln, k-1), if k>0
 *                        = sets(l2..ln,k), if k>0
 * Documentation:
 *  one_pair(L-initial list,K-number,R-reulted pair)
 *  flow model: (i,i,i),(i,i,o)
 */
 
one_pair(_,0,[]):- !.
one_pair([H|T],K,[H|R]):-
    K1 is K-1,
    one_pair(T,K1,R).
one_pair([_|T],K,R):-
    one_pair(T,K,R).


/* Mathematical model:
 *  gen_sets(l1l2...ln) = [], if n=0
 *                      = findall(one_pair(l1l2..ln,2))
 * Documentation:
 *  gen_sets(L-initial list,R-resulted list of pairs)
 *  flow model: (i,i), (i,o)
 */
gen_sets([],[]).
gen_sets(L,R):-findall(R1,one_pair(L,2,R1),R).
