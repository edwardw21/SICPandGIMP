(define (blur filename out-filename
                blur-radius)
    (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
          (drawable (car (gimp-image-get-active-layer image))))
    (plug-in-gauss-rle 1 image drawable blur-radius 1 1)
    (gimp-file-save RUN-NONINTERACTIVE image drawable out-filename out-filename)
    (gimp-image-delete image)
    (gimp-quit 0)))
