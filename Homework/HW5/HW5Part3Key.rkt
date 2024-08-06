#lang racket

; part 2
; 1 leetcode 136
(define (single-number L)
    (sn (sort L <)))

(define sn
  (lambda (L)
  (cond ((null? (cdr L)) (car L))
        ((eq? (car L) (cadr L)) (sn (cddr L)))
        (else (car L))
  ))
  )

;; 137 - change the call from sn to sn2

(define/contract (single-number2 nums)
 	 (-> (listof exact-integer?) exact-integer?)
  	(sn2 (sort nums <))
  	)

(define sn2
  (lambda (L)
  (cond ((null? (cdr L)) (car L))
        ((eq? (car L) (cadr L)) (sn2 (cdddr L)))
        (else (car L))
  ))
  )

;; 3. Leetcode
(define/contract (missing-number nums)
  (-> (listof exact-integer?) exact-integer?)
  (mn (sort nums >))
  )

(define mn
  (lambda (nums)
    (cond ((null? nums) 0)
          ((eq? (car nums) (length nums)) 
           (mn (cdr nums)))
          (else (length nums))
    )
  )
)

;; part III
;; 1. remove first and last element from a List

(define removeHT
  (lambda (L)         
    (cond ((< (length L) 3) '()) ;; length(L) < 3
           (else (reverse (cdr (reverse (cdr L))))))))
       
;; 2. remove all sublists, thus flaten the list
(define level
  (lambda (L)
    (cond ((null? L) L)
          ((not (list? (car L)))
           (cons (car L) (level (cdr L))))
          (else (append (level (car L)) (level (cdr L)))))))

;; 3. insert element e into list L at position p, which starts at 0
(define insert1
  (lambda (e p L)
    (cond ((< (length L) p) L) ;; p is out of scope, return with no change
           ((= 0 p) (cons e L))
           (else (cons (car L) (insert e (- p 1) (cdr L)))))))

;; use do loop
(define insert
  (lambda (e p L)
    (cond ((< (length L) p) L) ;; MI 
    (else
    (do ( (R '() (cons (car Lst) R))
          (Lst L (cdr Lst))
          (pos p (- pos 1))) ;; local var set up: init value, change at each iteration
        ((eq? pos 0) ;; test and return
         (append (reverse R) (list e) Lst)))))))
      ;; empty body 
;4. permu
(define permutation
  (lambda (L)
    (cond ((null? L) L)
          ((= 1 (length L)) (list L))
          (else (insertAll (car L) (permutation (cdr L)))))))

;; insert a new element everywhere (insertEverywhere)
;; of every sublist of a permutation list
(define insertAll
  (lambda (ele LL) ;; LL = list of lists
    (cond ((null? LL) LL)
          (else (append (insertEverywhere ele (car LL)) 
                        (insertAll ele (cdr LL)))))))

;; insertEverywhere - recursive version
#| (define insertEverywhere
  (lambda (ele L)
    (insertEverywhere1 ele L (length L) '())))

(define insertEverywhere1
  (lambda (ele L pos result)
    (cond ((< pos 0) result)
          (else (insertEverywhere1 ele L (- pos 1) (cons (insert ele pos L) result))))))
|#
 ;; iterative version
#|
  for (int pos=(length L), result='(); pos>=0 ;pos--, result = (cons (insert ele pos L) result)

  
|#
(define insertEverywhere
  (lambda (ele L)
    (do ((pos (length L) (- pos 1))
         (result '() (cons (insert ele pos L) result)))
        ((< pos 0) result) ;; test=true and return result
             ;(print "hello")
             ;;; body is empty, does nothing
     )
   )
 )


         