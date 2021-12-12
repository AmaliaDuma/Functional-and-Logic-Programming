% a. Write a predicate to substitute an element from a list with another element in the list.

/* Mathematical model:
 *  substitute(l1..ln,e1,e2) = [], if n=0
 *                           = e2 U substitute(l2..ln), if l1=e
 *                           = l1 U substitute(l2..ln), otherwise
 * Documentation:
 *  substitute(L-list,E1-number,E2-number,R-resulted list)
 *  flow model: (i,i,i,i), (i,i,i,o)
 */

substitute([],_,_,[]).
substitute([E1|T],E1,E2,[E2|R]):-!,
    substitute(T,E1,E2,R).
substitute([H|T],E1,E2,[H|R]):-
    substitute(T,E1,E2,R).


% b. Write a predicate to create the sublist (lm, ..., ln) from the list (l1,..., lk).

/* Mathematical model:
 *   create_sb(l1..ln,m,n,p) = [], if n=0
 *                           = l1 U create_sb(l2..ln,m,n,p+1), if m<=p<=n
 *                           = create_sb(l2..ln,m,n,p+1), otherwise
 * Documentation:
 *  create_sb(L-list,M-number,N-number,P-curent pos;number,R-resulted list)
 *  flow model: (i,i,i,i,o),(i,i,i,i,i)
 */

create_sb([],_,_,_,[]).
create_sb([H|T],M,N,P,[H|R]):-
    M=<P, P=<N,!,
    P1 is P+1,
    create_sb(T,M,N,P1,R).
create_sb([_|T],M,N,P,R):-
    P1 is P+1,
    create_sb(T,M,N,P1,R).


/* Mathematical model:
 *  create_sb_Main(l1..ln,m,n) = create_sb(l1..ln,m,n,1)
 * Documentation:
 *  create_sb_Main(L-list,M-number,N-number,R-resulted list)
 *  flow model(i,i,i,i),(i,i,i,o)
 */

create_sb_Main(L,M,N,R):-create_sb(L,M,N,1,R).
