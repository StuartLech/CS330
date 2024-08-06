;; Part III

;; 3.1 removeHT
;; removeHT – a function that accepts a list argument and returns a list with the head (first element) 
;; and tail (last element) removed.
(define removeHT
  (lambda (l)
    (cond ((< (length l) 3) '())
          (else (cdr (reverse (cdr (reverse l))))))))
          
;; Example usage:
;; (removeHT '((a b) c d e)) -> (c d)
;; (removeHT '(a b)) -> ()

;; 3.2 level
;; level - a procedure that takes a list argument and returns a list with all the original atoms as top-level elements.
;; Helper function to flatten a nested list
(define (flatten lst)
  (cond ((null? lst) '())
        ((not (pair? lst)) (list lst))
        (else (append (flatten (car lst)) (flatten (cdr lst))))))

;; Level function using flatten
(define level
  (lambda (l) (flatten l)))

;; Example usage:
;; (level '(a ("bb" c) d (e (4 g)))) -> (a "bb" c d e 4 g)

;; 3.3 insert
;; insert – a procedure that accepts an object obj, a nonnegative integer n, and a list L. 
;; It inserts obj into L at position n.
(define (insert item pos lst)
  (cond ((< pos 0) '("Invalid position: must be a non-negative integer"))
        ((> pos (length lst)) '("Invalid position: beyond list length"))
        ((= pos 0) (cons item lst))
        (else (cons (car lst) (insert item (- pos 1) (cdr lst))))))

;; Example usage:
;; (insert 'a 0 '(b c d)) -> (a b c d)
;; (insert 'a 3 '(b c d)) -> (b c d a)
;; (insert 'a 4 '(b c d)) -> ("Invalid position: beyond list length")

;; Optional: permutation
;; permutation - a procedure that accepts a list argument L and returns a list of all the permutations of L.
;; Helper function to insert an element into a list at every possible position
(define (insert-at-all-positions x lst)
  (if (null? lst)
      (list (list x))
      (append (map (lambda (rest) (cons x rest)) (insert-at-all-positions x (cdr lst)))
              (map (lambda (rest) (cons (car lst) rest)) (insert-at-all-positions x (cdr lst))))))

;; Permutations function using insert-at-all-positions
(define (permutations lst)
  (if (null? lst)
      '(())
      (apply append (map (lambda (perm) (insert-at-all-positions (car lst) perm)) 
                         (permutations (cdr lst))))))

;; Example usage:
;; (permutations '(a b c)) -> ((a b c) (b a c) (b c a) (a c b) (c a b) (c b a))
