; Q4
(define (rle s)
  (define (helper s elem n lst)
    (cond
      ((null? s)
        (cons-stream lst nil))
      ((= elem (car s))
        (helper (cdr-stream s) elem (+ 1 n) `(,elem ,(+ 1 n))))
      (else (cons-stream lst (helper s (car s) 0 nil)))))
  (if (null? s)
    nil
  (helper s (car s) 0 nil))
)

; Q4 testing functions
(define (list-to-stream lst)
    (if (null? lst) nil
                    (cons-stream (car lst) (list-to-stream (cdr lst))))
)

(define (stream-to-list s)
    (if (null? s) nil
                 (cons (car s) (stream-to-list (cdr-stream s))))
)

; Q5
(define (reverse lst)
  (define (helper lst so-far)
    (if (null? lst)
        so-far
        (helper (cdr lst) (cons (car lst) so-far))))
  (helper lst nil))

(define (insert n s)
  (define (helper s so-far)
    (cond
      ((null? s) (cons n so-far))
      ((< n (car s))
        (append (reverse s) (cons n so-far)))
      (else
        (helper (cdr s) (cons (car s) so-far)))))
  (reverse (helper s nil))
)



; Q6
(define (deep-map fn s)
  (cond
    ((null? s) nil)
    ((list? (car s)) (cons (deep-map fn (car s)) (deep-map fn (cdr s))))
    (else (cons (fn (car s)) (deep-map fn (cdr s)))))
)

; Q7
; Feel free to use these helper procedures in your solution
(define (map fn s)
  (if (null? s) nil
      (cons (fn (car s))
            (map fn (cdr s)))))

(define (filter fn s)
  (cond ((null? s) nil)
        ((fn (car s)) (cons (car s)
                            (filter fn (cdr s))))
        (else (filter fn (cdr s)))))

; Implementing and using these helper procedures is optional. You are allowed
; to delete them.
(define (unique s)
    (if (null? s)
        nil
        (cons (car s)
          (unique (filter (lambda (x) (not (equal? (car s) x))) (cdr s)))))
)

(define (count name s)
  (define (helper name s times)
    (cond
      ((null? s) times)
      ((eq? name (car s)) (helper name (cdr s) (+ 1 times)))
      (else (helper name (cdr s) times))))
  (helper name s 0)
)

;;; eq? & equal?
(define (tally names)
  (unique (map (lambda (x) (cons x (count x names))) names))
)