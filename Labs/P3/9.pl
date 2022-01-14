% Generate all permutation of N (N -given) respecting the property: for every 2<=i<=n exists an 1<=j<=i, so |v(i)-v(j)|=1.

/* Mathematical model:
 *  candidate9(n) = n, if n>=1
 *                = candidate(n-1), if n>1
 * Documentation:
 *  candidate(N-number,R-resulted nr)
 *  flow model (i,o)
 */
 
candidate9(N,N).
candidate9(N,R):-
    N>1, N1 is N-1,
    candidate9(N1,R).


/* Mathematical model:
 *  check_dif(l1..ln,e) = true, if abs(l1-e)=1
 *                      = check_dif(l2..ln,e), if n>=1
 *                      = false, otherwise
 * Documentation:
 *  check_dif(L-list, E-number)
 *  flow model: (i,i)
 */
 
check_dif([H|_],E):-
    abs(H-E) =:= 1,!.
check_dif([_|T],E):-
    check_dif(T,E).
    

/* Mathematical model:
 *  memberL(l1..ln,e) = true, if l1=e
 *                    = memberL(l2..ln,e), if n>=1
 *                    = false, otherwise
 * Documentation:
 *  memberL(L-list,E-number)
 *  flow model: (i,i)
 */

memberL([E|_],E).
memberL([_|T],E):-
    memberL(T,E).


/* Mathematical model:
 *  perm9(n) = perm9_aux(n,1,[candidate9(n)])
 * Documentation:
 *  perm9(N-number,R-resulted list)
 *  flow model: (i,o)
 */
 
perm9(N,R):-
    candidate9(N,E),
    perm9_aux(N,1,[E],R).


/* Mathematical model:
 *  perm9_aux(n,lg,a1..am) = a1..am, if lg = n
 *                         = perm9_aux(n,lg+1, a1..am U candidate9(n)),
 *                         if check_dif(a1..am,candidate9(n)) is true
 *                         and memberL(a1..am,candidate9(n)) is false
 * Documentation:
 *  perm9_aux(N-number,Lg-number,L-list,LR-resulted list)
 *  flow model: (i,o)
 */
 
perm9_aux(N,N,LC,LC):-!.
perm9_aux(N,Lg,[H|T],LR):-
    candidate9(N,E),
    check_dif([H|T],E),
    \+ memberL([H|T],E),
    add_endL([H|T],E,L1),
    Lg1 is Lg+1,
    perm9_aux(N,Lg1,L1,LR).


/* Mathematical model:
 *  perm9_main(n) = [], if n<=0
                  = findall(perm9(n))
 * Documentation:
 *  perm9_main(N-number,R-resulted list of perm)
 *  flow model: (i,o)
 */
 
perm9_main(N,[]):-N=<0.
perm9_main(N,R):-findall(R1,perm9(N,R1),R).












