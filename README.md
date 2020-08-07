# realm_of_racket





```jsx
	program	 	=	 	def-or-expr ...
 	 	 	 	 
  def-or-expr	 	=	 	definition
 	 	|	 	expr
 	 	|	 	test-case
 	 	|	 	library-require
 	 	 	 	 
  definition	 	=	 	(define (name variable ...) expr)
 	 	|	 	(define name expr)
 	 	|	 	(define-struct name (name ...))
 	 	|	 	(define-datatype name (name name ...) ...)
 	 	 	 	 
  expr	 	=	 	(begin expr expr ...)
 	 	|	 	(begin0 expr expr ...)
 	 	|	 	(set! variable expr)
 	 	|	 	(delay expr)
 	 	|	 	(lambda (variable ...) expr)
 	 	|	 	(λ (variable ...) expr)
 	 	|	 	(local [definition ...] expr)
 	 	|	 	(letrec ([name expr] ...) expr)
 	 	|	 	(shared ([name expr] ...) expr)
 	 	|	 	(let ([name expr] ...) expr)
 	 	|	 	(let name ([name expr] ...) expr)
 	 	|	 	(let* ([name expr] ...) expr)
 	 	|	 	(recur name ([name expr] ...) expr)
 	 	|	 	(expr expr ...)
 	 	|	 	(cond [expr expr] ... [expr expr])
 	 	|	 	(cond [expr expr] ... [else expr])
 	 	|	 	(case expr [(choice choice ...) expr] ...
           [(choice choice ...) expr])
 	 	|	 	(case expr [(choice choice ...) expr] ...
           [else expr])
 	 	|	 	(match expr [pattern expr] ...)
 	 	|	 	(if expr expr expr)
 	 	|	 	(when expr expr)
 	 	|	 	(unless expr expr)
 	 	|	 	(and expr expr expr ...)
 	 	|	 	(or expr expr expr ...)
 	 	|	 	(time expr)
 	 	|	 	name
 	 	|	 	’quoted
 	 	|	 	‘quasiquoted
 	 	|	 	’()
 	 	|	 	number
 	 	|	 	boolean
 	 	|	 	string
 	 	|	 	character
 	 	 	 	 
  choice	 	=	 	name
 	 	|	 	number
 	 	 	 	 
  pattern	 	=	 	_
 	 	|	 	name
 	 	|	 	number
 	 	|	 	true
 	 	|	 	false
 	 	|	 	string
 	 	|	 	character
 	 	|	 	’quoted
 	 	|	 	‘quasiquoted-pattern
 	 	|	 	(cons pattern pattern)
 	 	|	 	(list pattern ...)
 	 	|	 	(list* pattern ...)
 	 	|	 	(struct id (pattern ...))
 	 	|	 	(vector pattern ...)
 	 	|	 	(box pattern)
 	 	 	 	 
  quasiquoted-pattern	 	=	 	name
 	 	|	 	number
 	 	|	 	string
 	 	|	 	character
 	 	|	 	(quasiquoted-pattern ...)
 	 	|	 	’quasiquoted-pattern
 	 	|	 	‘quasiquoted-pattern
 	 	|	 	,pattern
 	 	|	 	,@pattern
 	 	 	 	 
  quoted	 	=	 	name
 	 	|	 	number
 	 	|	 	string
 	 	|	 	character
 	 	|	 	(quoted ...)
 	 	|	 	’quoted
 	 	|	 	‘quoted
 	 	|	 	,quoted
 	 	|	 	,@quoted
 	 	 	 	 
  quasiquoted	 	=	 	name
 	 	|	 	number
 	 	|	 	string
 	 	|	 	character
 	 	|	 	(quasiquoted ...)
 	 	|	 	’quasiquoted
 	 	|	 	‘quasiquoted
 	 	|	 	,expr
 	 	|	 	,@expr
 	 	 	 	 
  test-case	 	=	 	(check-expect expr expr)
 	 	|	 	(check-random expr expr)
 	 	|	 	(check-within expr expr expr)
 	 	|	 	(check-error expr expr ...)
 	 	|	 	(check-member-of expr expr expr)
 	 	|	 	(check-satisfied expr expr)
 	 	|	 	(check-range expr expr)
 	 	|	 	(check-range expr)
 	 	 	 	 
  library-require	 	=	 	(require string)
 	 	|	 	(require (lib string string ...))
 	 	|	 	(require (planet string package))
 	 	 	 	 
  package	 	=	 	(string string number number)

A name or a variable is a sequence of characters not including a space or one of the
 following:
   " , ' ` ( ) [ ] { } | ; #
A number is a number such as 123, 3/2, or 5.5.
A boolean is one of: #true or #false. Alternative spellings for the #true constant 
  are #t, true, and #T. Similarly, #f, false, or #F are also recognized as #false.
A symbol is a quote character followed by a name. A symbol is a value, just like 42,
  '(), or #false.
A string is a sequence of characters enclosed by a pair of ". Unlike symbols, 
  strings may be split into characters and manipulated by a variety of functions. 
  For example, "abcdef", "This is a string", and "This is a string with \\" inside" 
  are all strings.
A character begins with #\\ and has the name of the character. For example, #\\a, #\\b, 
  and #\\space are characters.
In function calls, the function appearing immediately after the open parenthesis can 
  be any functions defined with define or define-struct, or any one of the 
  pre-defined functions.
```

1. Scheme扩展Lisp的部分：赋值语句和控制流的跳转，其余都是语法糖;

2. Racket新增：

   1. 增加了结构、类系统、异常。
   2. 循环、模块、托管、事件空间。
   3. 图形用户界面库，以及其他许多东西。

3. 程序错误类型：

   1. 语法错误
   2. 运行时错误
   3. 逻辑错误

4. 语法和语义：grammar 和 meaning的意思

5. Racket的数据类型：

   1. Boolean
   2. Number：Integer、complex number、rational number
   3. Strings：
   4. Lists：functions（list、cons、car、cdr、first、rest）
   5. structure（Python：tuple）：struct、selector（structname-fieldname）、#:transparent（使打印透明）

6. Racket的条件式：

   1. 谓词判断：equality-predicates、
   2. IF：not false is true
   3. cond：中括号
   4. and 和or
   5. when和unless：unless 相当于not when
   6. equal？和 eq?区别

7. 测试套件（断言）：rackunit

8. definition：module级别，local级别

9. 数据：structure、union、递归类型

10. loop：返回多个值、#:result和#:when注解

    ```jsx
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
    ```