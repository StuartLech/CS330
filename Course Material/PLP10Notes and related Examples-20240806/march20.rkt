;L = (a b c d)  

;(car L) -> a
;(cdr L) -> (b c d)

(define (iReverse L)
  (cond ((null? L) L)
        (else (append (iReverse (cdr L)) (list (car L))))
  )
)

;; doReverse – loop version
(define doReverse
   (lambda (L)
	(do   ( (Lst L (cdr Lst) ) 
                (result '() (cons (car Lst) result) ) )
	         ( (null? Lst) result)
		;; empty loop body
          ))
    )
		

(define (reverseAll L)
  (cond ((null? L) L)
        ((list? (car L)) (append (reverseAll (cdr L)) (list (reverseAll (car L)))))
        (else (append (reverseAll (cdr L)) (list (car L))))
  )
)

