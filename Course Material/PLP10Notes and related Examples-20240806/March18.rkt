(require racket/trace)
(define sn
  (lambda (nl) ;; nl is a sorted list
  (cond ((null? (cdr nl)) (car nl))
        ((eq? (car nl) (cadr nl)) (sn (cddr nl))) ;; if 1st=2nd, recursive call with first 2 removed
        (else (car nl))
  ))
  )

;; interface
(define fibTR
  (lambda (n)
    (cond ( (<= n 2) 1)
          (else ( fibTR1 (- n 2) 1 1)))))

(define fibTR1
  (lambda (N f1 f2) ;; f1 and f2 are the values so far
    (cond ( (zero? N) f1)
          (else (fibTR1 (- N 1) (+ f1 f2) f1)))))	

(define sum
   (lambda (L) 					;; could also name the argument List, but not list
      (cond ( (null? L)  0) 			;; base case
	    ( else  (+ (car L) (sum (cdr L)) ))) 	
;; recursive case, return car(L)+sum(cdr(L)) in C++ format
   )                         
)

(define sumAll
   (lambda (L) 					;; could also name the argument List, but not list
      (cond ((null? L)  0) 			;; base case
            ( (list? (car L))
              (+ (sumAll (car L)) (sumAll (cdr L))))
	    ( else  (+ (car L) (sumAll (cdr L)) ))) 	
   )                         
)

(define iMember 
  (lambda (e L)
    (cond ( (null? L) #f )
              ( (equal? e (car L)) L)    ;; first element match
	  (else (iMember e (cdr L))))))


(define inList 
  (lambda (e L)
    (cond ( (null? L) #f )
              ( (equal? e (car L)) #t)    ;; first element match
          ( (list? (car L)) (or (inList e (car L)) (inList e (cdr L))))    
	  (else (inList e (cdr L))))))

;;Leetcode 507 – perfect number
(define check-perfect-number
  (lambda (num)
    (cpn num (quotient num 2) 0)))

(define cpn
  (lambda (num n sum)
    (cond ((zero? n)
           (let ((result (equal? num sum)))
             (print "Hello World")
             (newline)
             (play-sound "music1.mp3" #f)
             result))
          ((zero? (remainder num n)) (cpn num (- n 1) (+ sum n)))
          (else (cpn num (- n 1) sum)))))

