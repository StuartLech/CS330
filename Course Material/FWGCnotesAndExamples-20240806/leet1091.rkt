
;; Scheme Example - leetcode 1091

(require racket/trace) ;; load trace function

;; this function does a breadth-first search
(define bfs
  (λ (init goal grid)
    (do ( (path-list (list (list init))) ) ;; initialize the vars, we only have path-list, which is the Q
      
        ((or (null? path-list) (equal? goal (caar path-list))) ;; terminal condition
         (if (null? path-list) #f (reverse (car path-list)))) ;; return either empty or reverse of 1st path
      ;  (if (null? path-list) -1 (length ( car path-list))))
        (set! path-list (extend path-list grid))) ;; loop body
                                             ;; path-list = extend(path-list);
   )
)

;; check membership in a list, including sub-list of arbitary levels
;; (in 4 '(5 ((4 6)))
(define in 
  (lambda (a l)
    (cond ((null? l) #f)
          ((equal? a (car l)) #t)
          ((list? (car l)) 
           (or (in a (car l))(in a (cdr l))))
          (else (in a (cdr l))))))

(define (inbound L LL)
  (and (< -1 (car L)) (< -1 (cadr L)) (> LL (car L)) (> LL (cadr L))))
  
;; move does the actual move, called by the 8 ops
(define checkMove
  (lambda (L grid)
    (cond ((not (inbound L (length grid))) '())
          ((equal? (list-ref (list-ref grid (car L)) (cadr L)) 1) '())
          (else L))))
          
         
;; the following 8 are legal OPs 
(define up
  (lambda (L grid) ;; L = '(r c)
     (checkMove (list (- (car L) 1) (cadr L)) grid)))

(define down
  (lambda (L grid) ;; L = '(r c)
     (checkMove (list (+ (car L) 1) (cadr L)) grid)))

(define left
  (lambda (L grid) ;; L = '(r c)
     (checkMove (list (car L) (- (cadr L) 1)) grid)))

(define right
  (lambda (L grid) ;; L = '(r c)
     (checkMove (list (car L) (+ (cadr L) 1)) grid)))
    
(define NW
  (lambda (L grid) ;; L = '(r c)
     (checkMove (list (- (car L) 1) (- (cadr L) 1)) grid)))

(define NE
  (lambda (L grid) ;; L = '(r c)
     (checkMove (list (- (car L) 1) (+ (cadr L) 1)) grid)))

(define SE
  (lambda (L grid) ;; L = '(r c)
     (checkMove (list (+ (car L) 1) (+ (cadr L) 1)) grid)))

(define SW
  (lambda (L grid) ;; L = '(r c)
     (checkMove (list (+ (car L) 1) (- (cadr L) 1)) grid)))

(define getFirstNode caar)

;; make a list of OPs so we could call them in order without having to spell them out. 
;; Can we do that in C++?
(define op-list 
  '(up down left right NE SW NW SE))

 
;; you can change this list to other op-list to bfs of different puzzles
;; (define op-list '(up down left right)
(define extend 
   (lambda (L grid) ;; L is the local name for path-list in fwgc
     (do ((ops op-list (cdr ops)) ;; local name for the op-list, allowing us to walk through the op-list
          (cur-node (getFirstNode L)) ;; cur-node contains the list describing the current state such as (w w w w)
          (new-node '())) ;; initialize
       
       ((null? ops) (cdr L))         ;; terminal condition, remove cur-node when return
       
       (set! new-node ((eval (car ops)) cur-node grid)) ;; this calls the function on cur-node
       
       (if (and (not (null? new-node)) (not (in new-node L))) ;; if new-node is not null and not a repeat
           (set! L (append L (list (cons new-node (car L))))) '()) ; adding a new path at the end of lst
     )
   )
)

        
(bfs '(0 0) '(2 2) '((0 0 0) (1 1 0) ( 1 1 0)))