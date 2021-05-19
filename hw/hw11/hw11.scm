(define (find s predicate)
    (if (null? s)
        #f
        (if (predicate (car s))
            (car s)
            (find (cdr-stream s) predicate)))
)

(define (scale-stream s k)
    (cons-stream (* k (car s)) (scale-stream (cdr-stream s) k))
)

; Tortoise and Hare Algorithm 龟兔赛跑算法
; Floyd Cycle Detechtion Algorithm
(define (has-cycle s)
    (define (helper slow fast)
        (cond
            ((or (null? fast) (null? (cdr-stream fast))) #f)
            ((eq? slow fast) #t)
            (else (helper (cdr-stream slow)
                    (cdr-stream (cdr-stream fast))))))
    (helper s (cdr-stream s))
)
(define (has-cycle-constant s)
    (define (helper slow fast)
        (cond
            ((or (null? fast) (null? (cdr-stream fast))) #f)
            ((eq? slow fast) #t)
            (else (helper (cdr-stream slow)
                    (cdr-stream (cdr-stream fast))))))
    (helper s (cdr-stream s))
)
