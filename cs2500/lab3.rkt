#lang racket
(require test-engine/racket-tests)

(require 2htdp/image 2htdp/universe ) ;;rackunit

(define BACKGROUND-WIDTH 500)
(define BACKGROUND-HEIGHT 500)
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))
(define DOT-SIZE 10)
(define DOT-COLOR "black")
(define DOT-IMAGE (circle DOT-SIZE "solid" DOT-COLOR))
(define DOT-Y (/ BACKGROUND-HEIGHT 2))
(define TEXT-SIZE 20)
(define WIN-TEXT "YOU WIN!")
(define WIN-IMAGE (overlay (text WIN-TEXT TEXT-SIZE "dark green") BACKGROUND))
(define LOSE-TEXT "YOU LOSE :(")
(define LOSE-IMAGE (overlay (text LOSE-TEXT TEXT-SIZE "dark red") BACKGROUND))

(define (draw-game dotGame)
  (match dotGame
    [(? number? x-pos)
     (place-image DOT-IMAGE x-pos DOT-Y BACKGROUND)]
    [#t WIN-IMAGE]
    [#f LOSE-IMAGE]))

(define (move-dot dotGame)
  (match dotGame
    [(? number? x-pos)
     (random 0 BACKGROUND-WIDTH)]
    [#t dotGame]
    [#f dotGame]))

(check-random (move-dot 10) (random 0 BACKGROUND-WIDTH))

(define (change-if-click dotGame x-pos y-pos mouseEvent)
  (if(mouse=? mouseEvent "button-down")
  (match dotGame
    [(? number? dot)
     (within-dot? x-pos  y-pos dot)]
    [#t dotGame]
    [#f dotGame])
  dotGame))

; play-game : Number -> DotGame
; Play the dot game with the given initial x-position of the dot
(check-expect (within-dot? 10 DOT-Y 11) #t)
(check-expect (within-dot? 10 DOT-Y 100) #f)
(check-expect (within-dot? 10 0 11) #f)
(define (within-dot? x y dotx)
  (<= (sqrt (+ (sqr (- x dotx)) (sqr (- y DOT-Y)))) DOT-SIZE))

(define (play-game init-dot)
  (big-bang init-dot
    (to-draw draw-game)
    (on-tick move-dot)
    (on-mouse change-if-click)))
      
(play-game (random BACKGROUND-WIDTH))

(test)