; Sum of geometric progression, whose first term, 
; geometric ratio, and number of terms are a0, r, and n.
(define (sum-gp a0 r n)
  (* a0
     (if (= r 1)
       n
       (/ (- 1 (expt r n)) (- 1 r)))))
