#lang racket
;;(require test-engine/racket-tests)
(require 2htdp/image 2htdp/universe rackunit)

(define (greet-tracked-person person greet)
  (string-append greet ", " person))
(check-equal? (greet-tracked-person "Jerry" "Hungry for Milk")
              "Hungry for Milk, Jerry" "good" )

(define (big-and-red str)
  (text str 64 "red"))

(define (no-more-than-32 str)
  (substring str  0 (min (string-length str) 32) ))

(define (logo-and-slogan logo str)
  (place-image
   (beside
   logo
   (text str 20 "red"))
   1
   1
   (empty-scene
    1000 1000)))

(define (four-must-be-better logo)
  (overlay
   (place-image  logo 200 100 (empty-scene 1000 1000))
   logo
   logo))

(overlay/offset
 (underlay/offset 
  (ellipse 24 36 "solid" "black")
  -30 0
  (ellipse 24 36 "solid" "black"))
 0 18
 
(scene+curve
 (overlay
 (circle 60 'solid "yellow")
 (circle 61 'outline "black"))
   11 60 -90 2/3
   109 60 90 2/3
  "black"))

(define (convert-to-inches yard foot inches)
  (+ (* yard 36) (* foot 12) inches))
