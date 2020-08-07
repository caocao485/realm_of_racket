#lang racket
(require test-engine/racket-tests )
(require 2htdp/image 2htdp/universe ) ;rackunit
(require "shared.rkt")


(define clientstate0 "none available")

(define (launch-guess-client n)
  (big-bang clientstate0
    (to-draw draw-guess)
    (on-key handle-keys)
    (name n)
    (register LOCALHOST)
    (on-receive handle-msg)))

(define (handle-msg c msg)
  (number->string msg))

(define (handle-keys w key)
  (cond[(key=? key "up")(make-package w "up")]
       [(key=? key "down")(make-package w "down")]
       [(key=? key "q")(stop-with w)]
       [(key=? key "=")(stop-with w)]
       [else w]))

(define (draw-guess c)
  (overlay (text c SIZE COLOR)MT-SC))

(define TEXT-SIZE 16)
(define SIZE 18)

(define HELP-TEXT
  (text "↑ for larger numbers,↓ for smaller ones"
        TEXT-SIZE
        "blue"))
(define HELP-TEXT2
  (text "Press = when your number is guessed; q to quit."
        TEXT-SIZE
        "blue"))
(define COLOR "red")

(define TEXT-X 20)
(define TEXT-UPPER-Y 10)
(define TEXT-LOWER-Y 50)

(define MT-SC
  (place-image/align
   HELP-TEXT TEXT-X TEXT-UPPER-Y "left" "top"
   (place-image/align
    HELP-TEXT2 TEXT-X TEXT-LOWER-Y "left" "bottom"
    (empty-scene WIDTH HEIGHT))))

(define WIDTH 420)
(define HEIGHT 420)