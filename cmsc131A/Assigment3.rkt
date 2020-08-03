#lang racket
(require test-engine/racket-tests)
(require racket/date)
(require 2htdp/image 2htdp/universe ) ;;rackunit

(define (what-temp num)
  (cond
    [(< num 45)"cold"]
    [(<= 45 num 75)"comfy"]
    [(> num 75)"hot"]))
(check-expect (what-temp 45) "comfy")
(check-expect (what-temp 35) "cold")
(check-expect (what-temp 76) "hot")


(define (celsius->fahrenheit cel)
  (+ (* cel (/ 9 5)) 32))

(check-within (celsius->fahrenheit -50.0) -58.0 0.0001)
(check-within (celsius->fahrenheit 1.0) 33.8 0.0001)


(define (what-temp/celsius  cel)
  (what-temp (celsius->fahrenheit cel)))

(check-expect (what-temp/celsius 10) "comfy")
(check-expect (what-temp/celsius 78) "hot")
(check-expect (what-temp/celsius 1) "cold")

(define (which-light num)
  (cond
    [(< num 140)
     (circle 100 "solid" "red")]
    [(<= 140 num 224)
     (circle 100 "solid" "green")]
    [(< num 280)
     (circle 100 "solid" "yellow")]))



(define (time->light t)
  (which-light (remainder t 280)))

(define longMonthList
  (list "January" "February" "March" "April" "May" "June"
        "July" "August" "September" "October" "November"
        "December"))
(define shortMonthList
  (list "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug"
        "Sep" "Oct" "Nov" "Dec"))
(define days-in-year
  (list 0 31 (+ 31 28) (+ 62 28) (+ 62 30 28)
        (+ 62 30 31 28) (+ 62 30 31 30 28) (+ 62 30 31 30 31 28)
        (+ 62 30 31 30 31 31 28) (+ 62 30 31 30 31 31 30 28)
        (+ 62 30 31 30 31 31 30 31 28) (+ 62 30 31 30 31 31 30 31 30 28)))

(define (format-month m f)
  (match (index-of longMonthList m)
    [#f (match (index-of shortMonthList m)
          [(? number? index)
           (match f
             ["short" m]
             ["long" (list-ref longMonthList index)])])]
    [(? number? index)
     (match f
       ["short" (list-ref shortMonthList index)]
       ["long" m])]))
            
(check-expect (format-month "November" "long") "November")
(check-expect (format-month "November" "short") "Nov")
(check-expect (format-month "February" "short") "Feb")
(check-expect (format-month "February" "long") "February")


(define (year-month-day->date y m d o f)
  (match o
    ["MDY"
     (string-append (format-month m f) " " (number->string d)
                    ", " (number->string y))]
    ["DMY"
     (string-append (number->string d) " " (format-month m f) 
                    " " (number->string y))]))
(check-expect (year-month-day->date 1936 "November" 12 "MDY" "long")
              "November 12, 1936")
(check-expect (year-month-day->date  1936 "November" 12 "MDY" "short")
              "Nov 12, 1936")
(check-expect (year-month-day->date 1936 "November" 12 "DMY" "long")
              "12 November 1936")
(check-expect (year-month-day->date 1936 "November" 12 "DMY" "short")
              "12 Nov 1936")


(define (month->days-in-year month)
  (list-ref days-in-year (index-of longMonthList month )))
(check-expect (month->days-in-year "September") 243)

(define (year-month-day->days year month day)
  (+ (* year 365) (month->days-in-year month) (- day 1) ))

(check-expect (year-month-day->days 0 "January" 1)  0)
(check-expect (year-month-day->days 2017 "August" 28) 736444)

(define (days-between pre-y pre-m pre-d y m d)
  (- (year-month-day->days y m d) (year-month-day->days pre-y pre-m pre-d)))


(define (days->year number)
  (quotient  number 365))
(check-expect (days->year 365) 1)
(check-expect (days->year 364) 0)
(check-expect (days->year 736305) 2017)
(check-expect (days->year (year-month-day->days 1999 "December" 31)) 1999)


(define (days->month old-days)
  (let ([days (remainder old-days 365)])
  (cond[(< days 31) "January"]
       [(< days 59) "February"]
       [(< days 90) "March"]
       [(< days 120) "April"]
       [(< days 151) "May"]
       [(< days 181)"June"]
       [(< days 212)"July"]
       [(< days 243) "August"]
       [(< days 273) "September"]
       [(< days 304) "October"]
       [(< days 334) "November"]
       [(< days 365) "December"])))

(define (days-in-year->days-in-month daysInYear)
  (- daysInYear (list-ref days-in-year (index-of longMonthList (days->month daysInYear)))))

(define (days->day num)
  (+ (days-in-year->days-in-month (remainder num 365))1))

(check-expect (days->day  59) 1)
(check-expect (days->day 736324) 30)
(check-expect (days->day (year-month-day->days 1999 "December" 31)) 31)

(define init-year 1999)
(define init-month "December")
(define init-day 31)

(define init-time 72999)

(define (time-passing t)
  (let ([days (+ t init-time)])
  (place-image
   (text (string-append (year-month-day->date (days->year days) (days->month days) (days->day days)  "MDY" "long")
                         ", " (number->string days))20 "red")
   150 150
   (rectangle 300 300 "solid" "green"))))

(test)
(animate time-passing)