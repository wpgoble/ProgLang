; define pi
(define pi (* 4 (atan 1.0)))

; convert degree to radians
(define radian 
  (lambda (deg)
    (* deg (/ pi 180.0))))

; function that calculates a distance of 
; moving at a constant velocity in t seconds
(define freefall
  (lambda (vy)
    (/ (* 2.0 vy) 9.8)))

; horizontal distance
(define dx
  (lambda (vx t)
    (* vx t)))

;distance
(define (distance v ang)
  (dx
   (* v (cos (radian ang)))                     ; vx
   (freefall (* v (sin (radian ang))))))
