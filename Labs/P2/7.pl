% Determine the position of the maximal element of a linear list.
% Eg.: maxpos([10,14,12,13,14], L) produces L = [2,5].

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
 *  elem_pos(l1l2...ln,m,i) = [], if n=0
 *                          = i U elem_pos(l2...ln,m,i+1), if l1=m
 *                          = elem_pos(l2...ln,m,i+1), otherwise
 * Documentation:
 *  elem_pos(L-initial list, M-elem to find;number, I-index;number,R-resulted list with indexes)
 *  flow model: (i,i,i,o), (i,i,i,i)
 */
 
elem_pos([],_,_,[]).
elem_pos([M|T],M,I,[I|R]):-!,
    I1 is I+1,
    elem_pos(T,M,I1,R).
elem_pos([_|T],M,I,R):-
    I1 is I+1,
    elem_pos(T,M,I1,R).


/* Mathematical model:
 *  max_pos(l1l2...ln) = [], if n=0
                       = elem_pos(l1l2...ln, maxim_list(l1l2...ln),1)
 * Documentation:
 *  max_pos(L-initial list, R-resulted list with indexes)
 *  flow model: (i,i), (i,o)
 *
 */
 
max_pos([],[]).
max_pos(L,R):-
    maxim_list(L,M),
    elem_pos(L,M,1,R).


% For a heterogeneous list, formed from integer numbers and list of numbers, replace every sublist with the position of the maximum element from that sublist.
% [1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>[1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]

/* Mathematical model:
 *  replace_slWpos(l1l2...ln)
              = [], in n=0
 *            = max_pos(l1) U replace_slWpos(l2...ln), if is_list(l1) = true
 *            = l1 U replace_slWpos(l2...ln), otherwise
 * Documentation:
 *  replace_slWpos(L-initial list, R-resulted list)
 *  flow model: (i,i), (i,o)
 *
 */
 
replace_slWpos([],[]).
replace_slWpos([H|T],[I|R]):-
    is_list(H),
    max_pos(H,I),
    replace_slWpos(T,R).
replace_slWpos([H|T],[H|R]):-
    integer(H),
    replace_slWpos(T,R).

