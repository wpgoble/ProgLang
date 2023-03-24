; A function to return the absolute value of a real number
(define (absolute x)
  (if (< x 0)
    (* x -1)
    x))

; A function to return the reciprocal of a real number,
; make it return #f if the argument is 0
(define (reciprocal x)
  (if (= x 0)
    #f
    (/ 1 x)))

; Convert an integer to a graphical character of ASCII value. 
(define (convert x)
  (if (<= 33 n 126)
    (integer->char n)))

