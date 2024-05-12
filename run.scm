(load "sdf/manager/load")
(manage 'new 'generic-interpreter)
(init)

(define cat "cat.jpeg")
(define dog "dog.jpeg")

(vstack "output:" "catdog.jpeg" cat dog)
