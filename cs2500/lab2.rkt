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
   (triangle width "solid" "black")
   (place-image/align
    (rectangle (/ width 5) (* (/ width 5) 2) "solid" "yellow")
    (/ width 2) (/ width (/ 5 4)) "center" "center"
    (square width "solid" "red")
    )
   ))
(draw-house 100)

(define (pigify word)
  (string-append (substring word 1)
                 (substring word 0 1)
                 "ay"))
(check-equal? (pigify "fundies") "undiesfay")

(define (begins-with-vowels str)
  (not(not (member (substring str 0 1) (list "a" "e" "i" "o" "u")))))
(check-false (begins-with-vowels "dada"))
(check-true (begins-with-vowels "ad"))

(define (consonant? word)
  (not (member word (list "a" "e" "i" "o" "u"))))

(check-false (consonant? "a"))
(check-true (consonant? "d"))

(define (vowel-pos str)
  (define (iter substr count)
    (cond [(= (string-length substr) 0) #f]
          [(begins-with-vowels substr) count]
          [else(iter (substring substr 1) (+ 1 count))]))
  (iter str 0))

(define (pigify.v2 word)
  (match (vowel-pos word)
    [#f word]
    [0 (string-append word "ay")]
    [n (string-append (substring word  n ) (substring word 0 n ) "ay")]))
(check-equal? (pigify.v2 "shush") "ushshay")
(check-equal? (pigify.v2 "ussd") "ussday")
(check-equal? (pigify.v2 "ssd") "ssd")

(struct MauriceSendakBook (name year))

(define BookList
  (list (MauriceSendakBook "Chicken Soup with Rice" "1962" )
        (MauriceSendakBook "Where the Wild Things Are" "1963" )
        (MauriceSendakBook "Higglety Pigglety Pop!" "1967" )
        (MauriceSendakBook "In the Night Kitchen" "1970" )
        (MauriceSendakBook "Seven Little Monsters" "1977" )))

(define (next-book mauriceSendakBook)
  (let ([index (index-of BookList mauriceSendakBook)])
    (if(= index (- (length BookList) 1))
       (first BookList)
       (list-ref BookList (+ index 1)))))

(define (pre-book mauriceSendakBook)
  (let ([index (index-of BookList mauriceSendakBook)])
    (if(= index 0)
       (last BookList)
       (list-ref BookList (- index 1)))))

(define WIDTH 420)
(define HEIGHT 420)

(define TEXT-SIZE 16)
(define SIZE 18)

(define HELP-TEXT
  (text "← for pre-book,→ for next-book"
        TEXT-SIZE
        "blue"))
(define HELP-TEXT2
  (text "any other key to quit."
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

(define (start)
  (big-bang (list-ref BookList (random 0 (length BookList)))
    (on-key deal-with-guess)
    (to-draw render)))

(define (deal-with-guess w key)
  (cond [(key=? key "right")(next-book w)]
        [(key=? key "left")(pre-book w)]
        [else (stop-with w)]))

(define (render w)
  (overlay (text (string-append (MauriceSendakBook-name  w) "("  (MauriceSendakBook-year w) ")") SIZE COLOR)
           MT-SC))

