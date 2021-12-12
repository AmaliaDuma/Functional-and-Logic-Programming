% a. Define a predicate to test if a list of an integer elements has a "valley" aspect (a set has a "valley" aspect if elements decreases up to a certain point, and then increases.
% eg: 10 8 6 9 11 13 – has a “valley” aspect

/* Mathematical model:
 *  valley(l1..ln,f) = true, if n=1 and f=0
 *                   = valley(l2..ln,0), if l1<l2
 *                   = valley(l2..ln,1), if l1>l2
 *                   = false, otherwise
 * Documentation:
 *  valley(L-list,F-number)
 *  flow model(i,i)
 */

valley([_],0).
valley([H1,H2|T],_):-H1<H2,
    valley([H2|T],0),!.
valley([H1,H2|T],1):-H1>H2,
    valley([H2|T],1),!.


% b. Calculate the alternate sum of list’s elements(l1 -l2 + l3 ...).

/* Mathematical model:
 *  alternate_sum(l1..ln) = 0, if n=0
 *                        = l1, if n=1
 *                        = l1-l2 + alternate_sum(l3..ln), otherwise
 * Documentation
 *  alternate_sum(L-list,S-sum;number)
 *  flow model (i,i), (i,o)
 */

alternate_sum([],0).
alternate_sum([H],H).
alternate_sum([H1,H2|T],R):-
    alternate_sum(T,R1),
    R is H1-H2+R1.
