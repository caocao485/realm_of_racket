#lang racket
;;(require test-engine/racket-tests)
(require 2htdp/image 2htdp/universe rackunit)

(define (rewards log-days)
  (min 300 (+ 100 (* log-days 50))))
(check-equal? (rewards 4) 300)
(check-equal? (rewards 3) 250)
(check-equal? (rewards 30) 300)

(define (draw-house width)
  (above
   (triangle width "solid" "red")
   (place-image/align
    (rectangle (/ width 5) (* (/ width 5) 2) "solid" "yellow")
    (/ width 2) (/ width (/ 5 4)) "center" "center"
    (square width "solid" "black")
    )
   ))
(draw-house 100)