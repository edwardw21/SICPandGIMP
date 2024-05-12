;; #lang racket
(load "./sdf/manager/load")
(manage 'new 'generic-interpreter)
;;;; Skeleton compiler code, based on SDF section 5.1

(define (default-eval expression environment)
  (cond ((application? expression)
         (g:apply (g:advance
                   (g:eval (operator expression)
                           environment))
                  (operands expression)
                  environment))
        (else
         (error "Unknown expression type"
                expression))))

(define g:eval
  (simple-generic-procedure 'eval 2 default-eval))

(define g:advance
  (simple-generic-procedure 'g:advance 1 (lambda (x) x)))

;;;; self-evaluating use cases: probably only when we pass a constant or string as a parameter to an operation

(define-generic-procedure-handler g:eval
  (match-args self-evaluating? environment?)
  (lambda (expression environment)
    (declare (ignore environment))
    expression))

;;;; variable use cases: when referring to a stored image variable

(define-generic-procedure-handler g:eval
  (match-args variable? environment?)
  lookup-variable-value)

;;; definition use cases: when defining a variable for the first time (binding it to some image)

(define-generic-procedure-handler g:eval
  (match-args definition? environment?)
  (lambda (expression environment)
    (define-variable! (definition-variable expression)
      (g:eval (definition-value expression) environment)
      environment)
    (definition-variable expression)))

;;;; assignment use cases: when assigning a variable name to an image (after variable name is already defined)

(define-generic-procedure-handler g:eval
  (match-args assignment? environment?)
  (lambda (expression environment)
    (set-variable-value! (assignment-variable expression)
      (g:eval (assignment-value expression) environment)
      environment)))

;;;; apply generic procedures

(define (default-apply procedure operands calling-environment)
  (declare (ignore operands calling-environment))
  (error "Unknown procedure type" procedure))

(define g:apply
  (simple-generic-procedure 'apply 3 default-apply))

;;; strict primitive procedures should suffice? 

(define-generic-procedure-handler g:apply
  (match-args strict-primitive-procedure?
              operands?
              environment?)
  (lambda (procedure operands calling-environment)
    (apply-primitive-procedure procedure
      (eval-operands operands calling-environment))))

(define (eval-operands operands calling-environment)
  (map (lambda (operand)
         (g:advance (g:eval operand calling-environment)))
       operands))


