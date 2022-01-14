; Write a function that removes all occurrences of an atom from any level of a list.

; Mathematial model:
; remove_oc(l,e) = [], if l is atom and l=e
;                = [l], if l atom and l !=e
;                = remove_oc(l1,e)U..U remove_oc(li,e), i=from 1 to n, otherwise (l is list)

(defun remove_oc (l e)
  (cond
      ((and (atom l) (equal l e)) nil)
      ((and (atom l) (not (equal l e))) (list l))
      (t (list (mapcan #'(lambda (list) (remove_oc list e)) l)))
))

(defun remove_allOc (l e)
  (car (remove_oc l e)))
