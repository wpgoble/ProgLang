; A function that takes three real numbers as arguments. 
; It returns the product of these three numbers if all of 
; them are positive.
(define (positive_product a b c)
  (and (positive? a)
       (positive? b)
       (positive? c)
       (* a b c)))


; A function that takes three real numbers as arguments 
; It returns the product of these three numbers if at lease 
; one is negative.
(define (or_produce a b c)
  (if (or (positive? a)
          (positive? b)
          (positive? c))
    (* a b c)))


