#lang racket

(require "sicp/sicp-pict/main.rkt")

(require (for-syntax syntax/parse)
         racket/draw
         racket/snip
         racket/runtime-path
         racket/gui/base) ; dependencies needed for sicp-pict code

(define (file->painter filename)
  (define file (build-path filename))
  ; (define-runtime-path file filename)
  (bitmap->painter file))

(define (beside-filepaths filepath1 filepath2 output-filepath)
  (define outputfile (beside (file->painter filepath1)
                             (file->painter filepath2)))
  (paint-to-png outputfile output-filepath))

  