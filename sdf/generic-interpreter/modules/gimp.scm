(load-option 'synchronous-subprocess)
(load "common.scm")

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

