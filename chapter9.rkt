#lang racket

(for ([i '(1 2 3 4 5)])
  (display i))

(for-each display '(1 2 3 4 5))

(for/list ([i '(1 2 3 4 5)])
  (/ 1 i))


(map (lambda(x)(/ 1 x)) '(1 2 3 4 5))


(for/fold ([sqrs 0])
          ([i '(1 2 3 4 5 6 7 8 9 10)])
  (+(sqr i) sqrs))

(foldl (lambda(i sqrs)(+ (sqr i) sqrs))
       0
       '(1 2 3 4 5 6 7 8 9 10))

(for/fold ([sqrs 0]
           [count 0])
          ([i '(1 2 3 4 5 6 7 8 9 10)])
  (values (+ (sqr i)sqrs)
          (if(>(sqr i) 50)
             (add1 count)
             count)))

(values 42)

(values 'this 'and-this 'and-that)

(define-values (one two three)(values 'three 'two 'one))

(define-values (x y) (if(string=? "tuesday" "tuesday")
                        (values 10 20)
                        (values 42 55)))
x

(for/list ([i '(1 2 3 4 5)]
           #:when (odd? i))
  i)

(for/fold ([sum 0])
          ([i '(1 2 3 4 5)]
           #:when (even? i))
  (+ sum i))


(for*/list ([i '(1 2 3)]
            [j '(4 5 6)])
  (+ i j))
