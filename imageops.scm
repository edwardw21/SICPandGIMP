;;;; file to store functions related to image operations

				  ; (load "~/6.5150/ject/imageops.rkt") doesn't seem to work

(define (vstack . images)
  (display "called vstack")
  (newline)
  (display images)
  (newline))


(define (hstack . images)
  (display "called hstack")
  (newline)
  (display images)
  (newline))
