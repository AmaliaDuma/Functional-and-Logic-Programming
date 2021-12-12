% a. Insert an element on the positionn in a list.

/* Mathematical model:
 *  insertL(l1..ln,e,p) = [], if n=0 and p>1
 *                      = [e], if n=0 and p=1
 *                      = e U l1..ln, if p=1
 *                      = l1 U insertL(l2..ln,e,p-1), otherwise
 * Documentation:
 *  insertL(L-initial list,E-number,P-pos;number,R-resulted list)
 *  flow model: (i,i,i,i), (i,i,i,o)
 */

insertL([],_,P,[]):- P>1.
insertL([],E,P,[E]):- P=:=1.
insertL(L,E,P,[E|L]):- P=:=1.
insertL([H|T],E,P,[H|R]):- P>1,
    P1 is P-1,
    insertL(T,E,P1,R).


% b. Define a predicate to determine the greatest common divisor of all numbers from a list.

/* Mathematical model:
 *  gcd(a,b) = a, if b=0
 *           = b, if a=0
 *           = gcd(a%b,b), if a>=b
 *           = gcd(a,b%a), otherwise (a<b)
 * Documentation:
 *  gcd(A-number, B-number, R-Result)
 *  flow model: (i,i,i), (i,i,o)
 */
 
gcd(A,0,A):-!.
gcd(0,B,B):-!.
gcd(A,B,R):- A>=B,
    A1 is A mod B,
    gcd(A1,B,R).
gcd(A,B,R):- A<B,
    B1 is B mod A,
    gcd(A,B1,R).


/* Mathematical model: 
 *  gcd_list(l1..ln) = 0, if n=0
 *                   = l1, if n=1
 *                   = gcd(l1, gcd_list(l2..ln)), otherwise
 * Documentation:
 *  gcd_list(L-initial list,R-resulted gcd; number)
 *  flow model: (i,i), (i,o)
 */

gcd_list([],0).
gcd_list([H],H).
gcd_list([H|T],R):-
    gcd_list(T,R1),
    gcd(H,R1,R).
