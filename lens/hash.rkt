#lang racket

(provide
 (contract-out
  [hash-ref-lens (-> any/c lens?)]))

(require fancy-app
         "base/main.rkt")

(module+ test
  (require rackunit))


(define (hash-ref-lens1 key)
  (make-lens (hash-ref _ key)
             (hash-set _ key _)))

(define (hash-ref-lens . keys)
  (apply lens-thrush (map hash-ref-lens1 keys)))

(module+ test
  (define a (hash-ref-lens 'a))
  (define a-x (hash-ref-lens 'a 'x))
  (let-lens [val ctxt] a (hash 'a 1 'b 2 'c 3)
    (check-equal? val 1)
    (check-equal? (ctxt 100) (hash 'a 100 'b 2 'c 3)))
  (check-equal? (lens-transform* (hash 'a 1 'b 2 'c 3) a (* 10 _))
                (hash 'a 10 'b 2 'c 3))
  (let-lens [val ctxt] a-x (hash 'a (hash 'x 1 'y 2) 'b (hash 'z 3))
    (check-equal? val 1)
    (check-equal? (ctxt 100) (hash 'a (hash 'x 100 'y 2) 'b (hash 'z 3))))
  (check-equal? (lens-transform* (hash 'a (hash 'x 1 'y 2) 'b (hash 'z 3)) a-x (* 10 _))
                (hash 'a (hash 'x 10 'y 2) 'b (hash 'z 3))))