;;; Exercise 3.50

;;; stream operations
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-line x)
  (newline)
  (display x))
  
(define (display-stream s)
  (stream-for-each display-line s))


;;; stream elements
(define (memo-proc proc)
  (let ((already-run? false)
        (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? true)
                 result)
          result))))

(define (delay exp)
  (memo-proc (lambda () exp)))

(define (force delayed-object)
  (delayed-object))

(define (stream-car stream)
  (car stream))

(define (stream-cdr stream)
  (force (cdr stream)))

(define the-empty-stream '())

(define (stream-null? stream)
  (null? stream))



;;; Exercise 3.50
(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
        (apply proc (map stream-car argstreams))
        (apply stream-map
               (cons proc (map stream-cdr argstreams))))))

