% a. Write a predicate to determine the lowest common multiple of a list formed from integer numbers.
% b. Write a predicate to add a value v after 1-st, 2-nd, 4-th, 8-th, … element in a list.

% a

/* Mathematical model:
 *  gcd(a,b) = a, if b=0
 *           = b, if a=0
 *           = gcd(a%b,b), if a>=b
 *           = gcd(a,b%a), otherwise (a<b)
 * Documentation:
 *  gcd(A-number, B-number, R-resulted number)
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
 *  lcm(a,b) = a*b/gcd(a,b)
 * Documentation:
 *  lcm(A-number, B-number, R-resulted number)
 *  flow model: (i,i,i), (i,i,o)
 */
 
lcm(A,B,R):-
    gcd(A,B,R1),
    R is A*B/R1.


/* Mathematical model:
 *  lcm_list(l1l2...ln) = 0, if n=0
 *                      = l1, if n=1
 *                      = lcm(l1, lcm_list(l2...ln)), otherwise
 * Documentation:
 *  lcm_list(L-initial list, R-the lcm of the list;number)
 *  flow model: (i,i), (i,o)
 */
 
lcm_list([],0).
lcm_list([H],H).
lcm_list([H|T],R):-
    lcm_list(T,R1),
    lcm(H,R1,R).

% b

/* Mathematical model:
 *  insert_pow(l1l2...ln,v,p,i) = [], if n=0
 *                          = l1 U v U insert_pow(l2..ln,v,p*2,i+1),if p=i
 *                          = l1 U insert_pow(l2..ln,v,p,i+1), otherwise
 * Documentation:
 *  insert_pow(L-initial list, V-number, P-power of 2;number, I-index;number, R-resulted list)
 *  flow model(i,i,i,i,o), (i,i,i,i,i)
 */

insert_pow([],_,_,_,[]).
insert_pow([H|T],V,P,I,[H,V|R]):-
    P = I,!,
    I1 is I+1,
    P1 is P*2,
    insert_pow(T,V,P1,I1,R).
insert_pow([H|T],V,P,I,[H|R]):-
    I1 is I+1,
    insert_pow(T,V,P,I1,R).


/* Mathematical model:
 *  insert_powMain(l1l2..ln,v) = insert_pow(l1l2..ln,v,1,1)
 * Documentation:
 *  insert_powMain(L-initial list, V-number, R-resulted list)
 *  flow model: (i,i,i), (i,i,o)
 */

insert_powMain(L,V,R):-
    insert_pow(L,V,1,1,R).
