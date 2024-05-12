(load "sdf/manager/load")
(manage 'new 'generic-interpreter)

;; Direct interaction with gimp-module
(load "sdf/generic-interpreter/modules/gimp")
(call-procedure 'brighten "cat.jpeg" "cat_brighten.jpeg")

;; Main interface
(init)
(define cat "cat.jpeg")
(define dog "dog.jpeg")

(vstack "output:" "catdog.jpeg" cat dog)
(brighten cat "cat_brightened.jpg")
