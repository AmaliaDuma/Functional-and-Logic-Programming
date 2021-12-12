% a. Write a predicate to determine if a list has even numbers of elements without counting the elements from the list.

/* Mathematical model:
 *  even_list(l1l2...ln) = true, if n=0
 *                       = false, if n=1
 *                       = even_list(l3...ln), otherwise
 * Documentation:
 *  even_list(L-initial list)
 *  flow model: (i)
 */
 
even_list([]).
even_list([_,_|T]):-
    even_list(T).


% b. Write a predicate to delete first occurrence of the minimum number from a list.

/* Mathematical model:
 *  min_nr(a,b) = a, if a<=b
 *              = b, if b<a
 * Documentation:
 *  min_nr(A-number,B-number,R-resulted number)
 *  flow model: (i,i,i),(i,i,o)
 */

min_nr(A,B,A):- A=<B.
min_nr(A,B,B):- B=<A.


/* Mathematical model:
 *  minim_list(l1l2..ln) = l1, if n=1
 *                       = min_nr(l1,minim_list(l2...ln)), otherwise
 * Documentation:
 *  minim_list(L-initial list, R-resulted number)
 *  flow model (i,i), (i,o)
 */

minim_list([H],H).
minim_list([H|T],R):-
    minim_list(T,R1),
    min_nr(H,R1,R).


/* Mathematical model:
 *  del_firstOc(l1l2...ln,m) = [], if n=0
                             = l2...ln, if l1=m
 *                           = l1 U del_firstOc(l2...ln,m), otherwise
 * Documentation:
 *  del_firstOc(L-initial list, E-number to be deleted, R-resulted list)
 *  flow model: (i,i,i),(i,i,o),(i,o,i)
 */
 
del_firstOc([],_,[]).
del_firstOc([E|T],E,T):-!.
del_firstOc([H|T],E,[H|R]):-
    del_firstOc(T,E,R).


/* Mathematical model:
 *  del_firstMain(l1l2...ln) = del_firstOc(l1l2...ln,minim_list(l1l2...ln)
 * Documentation:
 *  del_firstMain(L-initial list,R-resulted list)
 *  flow model: (i,i),(i,o)
 */

del_firstMain([],[]).
del_firstMain(L,R):-
    minim_list(L,R1),
    del_firstOc(L,R1,R).
