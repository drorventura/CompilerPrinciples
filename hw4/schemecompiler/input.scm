(define accumulate 
        (lambda (op initial sequence) 
                (if (null? sequence) 
                        initial 
                        (op (car sequence) (accumulate op initial (cdr sequence))))))

(define ls  '((1 2 3) (4 6 7) (8 9)))

(accumulate append (list) (map (lambda (x) x) ls))

(accumulate append (list) (map cdr ls))

(define flatmap(lambda (proc seq) 
 (accumulate append (list) (map proc seq)))) 

(define (filter1 pred? lst)
  (cond ((null? lst) (list ))
        ((pred? (car lst)) (cons (car lst) (filter1 pred? (cdr lst))))
        (else (filter1 pred? (cdr lst)))))

 (flatmap (lambda (lst) (filter1 (lambda(x)  (= (remainder x 2) 1))  lst))  ls) 
 
 (define id (lambda (x) x))
 
 (define fib$ 
        (lambda (n c) 
                (cond ((= n 0) (c 0)) 
                      ((= n 1) (c 1)) 
                      (else (fib$ (- n 1) (lambda (fib-n-1) 
                                                (fib$ (- n 2) (lambda (fib-n-2) 
                                                                        (c (+ fib-n-1 fib-n-2)))))))))) 
 (fib$ 7 id)
 
 (define not1 
        (lambda (x)
                (if x 
                    #f
                    #t)))
                    
(define mul-list$ 
        (lambda (ls succ fail) 
                (cond ((null? ls) (succ 1)) 
                      ((not1 (pair? ls)) (if (number? ls) (succ ls) (fail 'not-a-number!))) 
                      (else (mul-list$ (car ls) 
                                       (lambda (mul-car) 
                                               (mul-list$ (cdr ls) 
                                                           (lambda (mul-cdr) 
                                                            (succ (* mul-car mul-cdr))) 
                                                fail)) 
                                         fail))))) 

(mul-list$ (list 1 2 (list 3 4 5) (list 6 7 10)) (lambda (x) x) (lambda (x) x)) 

(mul-list$ '(1 2 (3 4 5) (6 7 'a)) (lambda (x) x) (lambda (x) x))
