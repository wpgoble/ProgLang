(define e
  (lambda (n x)
    (if (zero? n)
      1
      (* x
         (e (- n 1) x)))))
