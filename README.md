# SICPandGIMP
Image manipulation library leveraging capabilities of the SICP Picture Language as well as the GIMP Photo Editing Library. 

For the SICP Picture Language, we can mostly borrow the functionality from the Picture Language (see here for SICP codebase: https://github.com/sicp-lang/sicp), but we will require some changes because the picture language only considers square images. 

The appropriate changes are stored in the file main.rkt in this repository. 

For the compiler, we can mostly borrow the functionality from the generic interpreter detailed in SDF section 5.1. We won't need most of the functionality, only keeping the parts which handle:

- self-evaluating expressions (e.g. "catdog.jpg", 2.0)
- variables (e.g. cat which could correspond to an image, or scaling-factor which could correspond to a float)
- procedures (to implement the image manipulation operations)
- definitions (expressions to assign variable names to values)
- assignments (expressions to re-assign variable names)

The changes we add are:

- creating new predicates corresponding to function calls to built-in image manipulation operations
- creating the corresponding generic procedures to parse these function calls
- creating a new file imageops.scm to store the procedures for the image operations (imageops.scm, which should also be added to the load-spec)

Example invocation: 

```
(init)


eval> (define cat "images/cat.jpeg")
cat

eval> (define dog "images/dog.jpge")
dog

eval> (vstack "output:" "images/catdog.jpeg" cat dog)
```

The modified compiler and syntax are in interp.scm and shared-syntax.scm, the appropriate changes will need to be made to the corresponding files in sdf/generic-interpreter for the project to run. Also, imageops.scm needs to be added to sdf/generic-interpreter. 

The overall project setup is as follows:

project is a folder which contains:

- sdf (with generic-interpreter modified as above, two file modifications and imageops.scm addition)
- run.scm (simple file to invoke the compiler in generic-interpreter)
- sicpops.rkt (Racket file containing the contents of main.rkt in our repo), and compiled executable sicpops (compile with raco exe sicpops.rkt). 
- scratch (folder to store intermediate image manipulation outputs)

To start the project, open run.scm and run the commands.





