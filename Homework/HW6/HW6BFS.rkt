;; Scheme Water Jug Problem Solution

(require racket/trace) ;; load trace function

(define (string-join lst sep)
  (if (null? lst)
      ""
      (let loop ((lst (cdr lst))
                 (acc (car lst)))
        (if (null? lst)
            acc
            (loop (cdr lst) (string-append acc sep (car lst)))))))

(define (update-jugs a b a-max b-max)
  (list a b a-max b-max))

(define (FillA L)
  (update-jugs (caddr L) (cadr L) (caddr L) (cadddr L)))

(define (FillB L)
  (update-jugs (car L) (cadddr L) (caddr L) (cadddr L)))

(define (EmptyA L)
  (update-jugs 0 (cadr L) (caddr L) (cadddr L)))

(define (EmptyB L)
  (update-jugs (car L) 0 (caddr L) (cadddr L)))

(define (AtoB L)
  (let* ((a (car L))
         (b (cadr L))
         (a-max (caddr L))
         (b-max (cadddr L))
         (transfer (min a (- b-max b))))
    (update-jugs (- a transfer) (+ b transfer) a-max b-max)))

(define (BtoA L)
  (let* ((a (car L))
         (b (cadr L))
         (a-max (caddr L))
         (b-max (cadddr L))
         (transfer (min b (- a-max a))))
    (update-jugs (+ a transfer) (- b transfer) a-max b-max)))

(define (goal-state? state goal)
  (equal? (car state) goal))

(define (safe-operation? state)
  (let ((a (car state)) (b (cadr state)) (a-max (caddr state)) (b-max (cadddr state)))
    (and (<= 0 a a-max) (<= 0 b b-max))))

(define op-list 
  (list FillA FillB EmptyA EmptyB AtoB BtoA))

(define (state->string state)
  (string-join (map number->string state) "-"))

(define (extend-jugs lst seen)
  (let ((cur-path (car lst))
        (new-paths '())
        (new-seen seen))
    (for-each
     (lambda (op)
       (let ((new-state (op (car cur-path)))
             (new-state-str ""))
         (set! new-state-str (state->string new-state))
         (when (and (safe-operation? new-state)
                    (not (member new-state-str seen)))
           (set! new-seen (cons new-state-str new-seen))
           (set! new-paths (append new-paths (list (cons new-state cur-path))))))
     )
     op-list)
    (values (append new-paths (cdr lst)) new-seen)))

(define (bfs-jugs init goal)
  (let* ((init-str (state->string init))
         (path-list (list (list init)))
         (seen (list init-str)))
    (let loop ((path-list path-list) (seen seen))
      (if (null? path-list)
          '() ;; No solution found
          (let ((cur-path (car path-list)))
            (if (goal-state? (car cur-path) goal)
                (reverse cur-path) ;; Solution found
                (let-values (((new-path-list new-seen) (extend-jugs path-list seen)))
                  (loop new-path-list new-seen))))))))

(define (jugs sizeA sizeB goal)
  (bfs-jugs (list 0 0 sizeA sizeB) goal))

(define (printjugs solution)
  (define (describe-step prev cur)
    (cond ((equal? cur (FillA prev)) "Fill-A")
          ((equal? cur (FillB prev)) "Fill-B")
          ((equal? cur (EmptyA prev)) "Empty-A")
          ((equal? cur (EmptyB prev)) "Empty-B")
          ((equal? cur (AtoB prev)) "A-to-B")
          ((equal? cur (BtoA prev)) "B-to-A")
          (else "Unknown")))
  (let ((prev (car solution)))
    (for-each
     (lambda (cur)
       (let ((step (describe-step prev cur)))
         (displayln step)
         (set! prev cur)))
     (cdr solution))))

;; (FillA '(0 2 5 3))
;; (FillB '(0 2 5 3))
;; (EmptyA '(3 2 5 3))
;; (EmptyB '(2 3 5 3))
;; (AtoB '(5 2 5 3))
;; (AtoB '(2 0 5 3))
;; (BtoA '(0 3 5 3))


;; (jugs 5 3 4)

;; (printjugs (jugs 5 3 4))

