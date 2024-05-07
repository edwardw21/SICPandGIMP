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

Example invocation: 

```
(init)


eval> (define cat "cat.jpg")
cat

eval> (define dog "dog.jpg")
dog

eval> (vstack (list cat 100 200) (list dog 300 400) "catdog.jpg")
called vstack
((cat.jpg 100 200) (dog.jpg 300 400) catdog.jpg)
#!unspecific
```

The modified compiler and syntax are in compiler.scm and shared-syntax.scm, the appropriate changes will need to be made to the corresponding files in sdf/generic-interpreter for the project to run. 



