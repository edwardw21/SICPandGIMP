(load-option 'synchronous-subprocess)
(load "sdf/manager/load")
(manage 'new 'generic-procedures)

(define (assert predicate item . error-msg)
  (define msg (if (null? error-msg)
		  "assertion failed"
		  (car error-msg)))
  (if (not (predicate item))
      (error msg)))

(define ensure-string
  (simple-generic-procedure 'enure-string 1 #f))

(define-generic-procedure-handler ensure-string
  (match-args string?)
  (lambda (value) value))

(define-generic-procedure-handler ensure-string
  (match-args number?)
  (lambda (value)
    (number->string value)))

(define-generic-procedure-handler ensure-string
  (match-args symbol?)
  (lambda (value)
    (symbol->string value)))

(define (list->spaced-string lst)
  (if (null? lst)
      ""
      (string-append
       (ensure-string (car lst))
       (let ((cdr-string (list->spaced-string (cdr lst))))
	 (if (equal? cdr-string "")
	     cdr-string
	     (string-append " " cdr-string))))))

(define-generic-procedure-handler ensure-string
  (match-args list?)
  (lambda (value)
    (list->spaced-string value)))

(define-generic-procedure-handler ensure-string
  (match-args boolean?)
  (lambda (value)
    (if value "#t" "#f")))

(define (split-string str delimiter)
  (let loop ((pos 0)
             (acc '()))
    (let ((next-pos (string-index str delimiter pos)))
      (if (not next-pos)
          (reverse (cons (substring str pos (string-length str)) acc))
          (loop (+ next-pos 1)
                (cons (substring str pos next-pos) acc))))))

(define (string-index str char start)
  (let loop ((i start))
    (cond ((>= i (string-length str)) #f)
          ((char=? (string-ref str i) char) i)
          (else (loop (+ i 1))))))

(define (files-in-directory directory)
  (split-string
   (call-with-output-string
    (lambda (port)
      (run-shell-command
       (string-append "ls " directory)
       'output port)))
   #\newline))

(define (build-command procedure-name input-file output-file args)
  (string-append
    "gimp -i -b '("
    (ensure-string procedure-name)
    " \""
    (ensure-string input-file)
    "\" \""
    (ensure-string output-file)
    (let ((arg-string (ensure-string args))
	  (command-termination ")' -b '(gimp-quit 0)'"))
      (if (equal? arg-string "")
	  (string-append "\"" command-termination)
	  (string-append "\" " arg-string command-termination)))))

(define (call-procedure procedure-name input-file output-file . args)
  (run-shell-command (build-command
		      procedure-name
		      input-file
		      output-file
		      args)))
