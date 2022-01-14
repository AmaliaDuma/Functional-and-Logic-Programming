; Return the level of a node X in a tree of type (1). The level of the root element is 0.
; type (1) : (A 2 B 0 C 2 D 0 E 0)

#||
Mathematical model:
   get_left(l1..ln, v, m) = nil, if n=0
                          = nil, if v = m + 1
                          = l1 U l2 U get_left(l3..ln, v+1, m+l2), otherwise
||#

(defun get_left (l v m)
  (cond
      ((null l) nil)
      ((= v (+ m 1)) nil)
      (t (cons (car l) (cons (cadr l) (get_left (cddr l) (+ v 1) (+ m (cadr l))))))
))

#||
Mathematical model:
   left(l1..ln) = get_left(l3..ln, 0, 0)
||#

(defun left (l)
  (get_left (cddr l) 0 0))

#||
Mathematical model:
   get_right(l1..ln, v, m) = nil, if n=0
                           = l1..ln, if v = m + 1
                           = get_right(l3..ln, v+1, m+l2), otherwise
||#

(defun get_right (l v m)
  (cond
      ((null l) nil)
      ((= v (+ m 1)) l)
      (t (get_right (cddr l) (+ v 1) (+ m (cadr l))))
))

#||
Mathematical model:
   right(l1..ln) = get_right(l3..ln, 0, 0)
||#

(defun right (l)
  (get_right (cddr l) 0 0))

#||
Mathematical model:
   node_level_aux(l1..ln, e, lvl) = -1, if n=0
                                  = lvl, if e = l1
                                  = node_level_aux(left(l1..ln), e, lvl+1),
                                                      if (node_level_aux(left, e, lvl+1)) !=-1
                                  = node_level_aux(right(l1..ln), e, lvl+1)
||#

(defun node_level_aux (l e lvl)
  (cond
      ((null l) -1)
      ((equal e (car l)) lvl)
      ((/= (set 'X (node_level_aux (left l) e (+ 1 lvl))) -1) (eval 'X))
      (t (node_level_aux (right l) e (+ 1 lvl)))
))

#||
Mathematical model:
   node_level(l1..ln, e) = node_level_aux(l1..ln, e, 0)
||#

(defun node_level (l e)
  (node_level_aux l e 0))
