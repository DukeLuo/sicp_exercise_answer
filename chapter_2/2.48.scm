#lang scheme
;;; Exercise 2.48

;;; Painters
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame)
         (start-segment segment))
        ((frame-coord-map frame)
         (end-segment segment))))
     segment-list)))

;;; Exercise 2.48
(define (make-segment v1 v2)
  (list v1 v2))
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cadr segment))

