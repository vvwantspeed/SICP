; Q1
(define (compose-all funcs)
    (cond
        ((null? funcs) (lambda (x) x))
        ((null? (cdr funcs))
            (lambda (x) ((car funcs) x)))
        (else
            (lambda (x) 
                ((compose-all (cdr funcs)) ((car funcs) x)))))
)

; Q2
(define (tail-replicate x n)
    (define (helper x n lst)
        (if (= 0 n)
            lst
            (helper x (- n 1) (cons x lst))))
    (helper x n nil)
)