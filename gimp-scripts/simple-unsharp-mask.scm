(define (simple-unsharp-mask filename out-filename
                              radius
                  amount
                  threshold)
   (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
          (drawable (car (gimp-image-get-active-layer image))))
     (plug-in-unsharp-mask RUN-NONINTERACTIVE
                       image drawable radius amount threshold)
     (gimp-file-save RUN-NONINTERACTIVE image drawable out-filename out-filename)
     (gimp-image-delete image)
     (gimp-quit 0)))
