; a) Write a function to return the difference of two sets.

#||
contains(l1..ln,e) = false, if n=0
                   = true, if l1=e
                   = contains(l2..ln,e), otherwise
||#

(defun contains (l e)
  (cond
      ((null l) nil)
      ((equal (car l) e) t)
      (t (contains (cdr l) e))
))

#||
difference(l1..ln, p1..pm) = [], if n=0
                          = l1 U difference(l2..ln,p1..pm), if contains(p1..pm,l1)=false
                          = difference(l2..ln,p1..pm), otherwise
||#

(defun difference(l p)
  (cond
      ((null l) nil)
      ((not (contains p (car l))) (cons (car l) (difference (cdr l) p)))
      (t (difference (cdr l) p))
))

; b) Write a function to reverse a list with its all sublists, on all levels.

#||
add_end(l1..ln,e) = e, if n=0
                  = l1 U add_end(l2..ln,e), otherwise
||#

(defun add_end(l e)
  (cond
      ((null l) (list e))
      (t (cons (car l) (add_end (cdr l) e)))
))

#||
reverse_all(l1..ln) = [], if n=0
                    = add_end(reverse_all(l2..ln), reverse_all(l1)), if l1=list
                    = add_end(reverse_all(l2..ln),l1), otherwise
||#

(defun reverse_all(l)
  (cond
      ((null l) nil)
      ((listp (car l)) (add_end (reverse_all (cdr l)) (reverse_all (car l))))
      (t (add_end (reverse_all (cdr l)) (car l)))
))

; c) Write a function to return the list of the first elements of all list elements of a given list with an odd 
;number of elements at superficial level. Example:(1 2 (3 (4 5) (6 7)) 8 (9 10 11)) => (1 3 9).

#||
len(l1..ln) = 0, if n=0
            = 1 + len(l2..ln), otherwise
||#

(defun len(l)
  (cond
      ((null l) 0)
      (t (+ 1 (len (cdr l))))
))

(defun odd_len(l)
  (= (mod (len l) 2) 1))

#||
f_elems(l1..ln) = [], if n=0
                = p1 (l1=p1..pm) U f_elems(l2..ln), if l1 list and odd_len(l1) is true
                = f_elems(l2..ln), otherwise
||#

(defun f_elems(l)
  (cond
      ((null l) nil)
      ((and (listp (car l)) (odd_len (car l))) (cons (caar l) (f_elems (cdr l))))
      (t (f_elems (cdr l)))
))

#||
f_elems_main(l1..ln) = l1 U f_elems(l1..ln) , if odd_len(l1..ln) is true
                     = f_elems(l1..ln), otherwise
||#

(defun f_elems_main(l)
  (cond
      ((odd_len l) (cons (car l) (f_elems l)))
      (t (f_elems l))
))

; d) Write a function to return the sum of all numerical atoms in a list at superficial level.

#||
sumSL(l1..ln) = 0, if n=0
              = l1 + sumSL(l2..ln), if numberp(l1) is true
              = sumSL(l2..ln), otherwise
||#

(defun sumSL(l)
  (cond
      ((null l) 0)
      ((numberp (car l)) (+ (car l) (sumSL (cdr l))))
      (t (sumSL (cdr l)))
))
