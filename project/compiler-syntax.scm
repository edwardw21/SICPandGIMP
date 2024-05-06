#lang racket

(define (self-evaluating? exp)
  (or (number? exp)
      (boolean? exp)
      (string? exp)))   ; Our prompt (viz., "EVAL==> ") is a string.
(register-predicate! self-evaluating? 'self-evaluating)

(define (variable? exp) (symbol? exp))
(register-predicate! variable? 'variable)

(define (tagged-list? exp tag)
  (and (pair? exp)
       (eq? (car exp) tag)))
(register-predicate! tagged-list? 'tagged-list)

(define (quoted? exp) (tagged-list? exp 'quote))
(register-predicate! quoted? 'quoted)

;;; ex: (define cat "~/cat.jpg)

(define (definition? exp) (tagged-list? exp 'define))
(register-predicate! definition? 'definition)

(define (definition-variable assn) (cadr  assn))
(define (definition-value    assn) (caddr assn))

;;; ex: (set! cat "~/cat.jpg")

(define (assignment? exp) (tagged-list? exp 'set!))
(register-predicate! assignment? 'assignment)

(define (assignment-variable assn) (cadr  assn))
(define (assignment-value    assn) (caddr assn))


