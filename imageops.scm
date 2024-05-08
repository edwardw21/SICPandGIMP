;;;; file to store functions related to image operations


;(load "~/6.5150/project/imageops.rkt") doesn't seem to work
; instead we make system calls to sicpops executable in ~/6.5150/project


(define (vstack . images)
  (display (random 26))
  (newline)
  (if (null? images)
      (display "No images provided")
      (if (string=? (car images) "output:")
          (begin ; system call: ./project/sicpops vstack [cadr images] [rest of images]
            (display "Output location: ")
            (display (cadr images)) ; Print the cadr of images
            (newline)
            (display "Remaining images: ")
            (display (cddr images))) ; Print the cddr of images
          (begin ; system call: ./project/sicpops vstack [random output location in scratch/] [rest of images]
	    (display "Images:")
	    (newline)
	    (display images))))
      (newline)) ; return output location at the end 

(define (hstack . images)
  (display (random 26))
  (newline)
  (if (null? images)
      (display "No images provided")
      (if (string=? (car images) "output:")
          (begin ; system call: ./project/sicpops hstack [cadr images] [rest of images]
            (display "Output location: ")
            (display (cadr images)) ; Print the cadr of images
            (newline)
            (display "Remaining images: ")
            (display (cddr images))) ; Print the cddr of images
          (begin ; system call: ./project/sicpops hstack [random output location in scratch/] [rest of images]
	    (display "Images:")
	    (newline)
	    (display images))))
      (newline))

(define (rescale . images)
  (display (random 26))
  (newline)
  (if (null? images)
      (display "No images provided")
      (if (string=? (car images) "output:")
          (begin ; system call: ./project/sicpops rescale [cadr images] [rest of args]
            (display "Output location: ")
            (display (cadr images)) ; Print the cadr of images
            (newline)
            (display "Remaining images: ")
            (display (cddr images))) ; Print the cddr of images
          (begin ; system call: ./project/sicpops rescale [random output location in scratch/] [rest of images]
	    (display "Images:")
	    (newline)
	    (display images))))
      (newline))

(define (save . args)
  (display "called save")
  (newline)
  (display args)
  (newline))
