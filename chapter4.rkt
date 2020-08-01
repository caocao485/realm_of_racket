#lang racket
;;(require test-engine/racket-tests)
(require 2htdp/image 2htdp/universe rackunit)

(struct student (name id# torm))

(define e1 (student 'hello 1 '2))
(student? e1)