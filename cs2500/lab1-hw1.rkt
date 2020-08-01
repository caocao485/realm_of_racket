#lang racket
(require test-engine/racket-tests)
(require 2htdp/image)
(require 2htdp/universe)



(define divisible-by3?
  (lambda(n)
    (= (remainder n 3) 0)))





;; Exercise 10 
;;(if x #t #f) -> (not(not x))

;;(if y #f #t) -> (not y)

;;(cond [x y] [y #f] [else x]) -> (and x y)

;;(cond [(< (+ x 6) (* y 7)) #t] [(> (+ x 2) (* y 2)) #f] [else #t]) -> (or (<(+ x 6)(* y 7)) (< (+ x 2)(* y 2)))


;; Exercise 11
(define charge-to-numbers
  (lambda(price)
   (- 5000 (* (- price 500)2))))

(check-expect (charge-to-numbers 501) 4998)



(define (blarney x y z)
  (string-length
   (replicate (modulo y z) (substring x z y))))

(define (replicate n string)
  (match n
    [0 ""]
    [1 string]
    [_ (string-append string (replicate (- n 1) string))]))


(check-expect (replicate 2 "12") "1212")
(check-expect (blarney "abcdef" 5 2) 3)


;;x y
;;0 -3
;;1 -2
;;2 1
;;3 6
(define (f x)
  (- (* x x) 3))
(check-expect (f 0) -3)
(check-expect (f 1) -2)
(check-expect (f 2) 1)
(check-expect (f 3) 6)


;;signature string -> string
(define (self-replicate str)
  (replicate (string-length str) str))

(check-expect (self-replicate "1") "1")
(check-expect (self-replicate "12") "1212")

(test)
