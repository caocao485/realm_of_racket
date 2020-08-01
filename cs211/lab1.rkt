#lang racket
(require test-engine/racket-tests)
(require 2htdp/image)
(require 2htdp/universe)

(underlay (rectangle 500 350 "solid" (color 0 40 104 255))
          (rectangle 80 350 "solid" "white")
          (rectangle 500 80 "solid" "white")
          (circle 80 "solid" "white")
          (circle 40 "solid" (color 191 10  48 255))
          (star 40 "solid" "white"))

(define circle-on-scence
  (lambda(n)
    (overlay (circle n "solid" "red")
             (empty-scene 500 350 "white"))))


(animate circle-on-scence)