#!/bin/bash

gimp -i -b '(simple-unsharp-mask "cat.jpeg" 5.0 0.5 0)' -b '(gimp-quit 0)'

gimp -i -b '(blur "dog.jpeg" 5.0)' -b '(gimp-quit 0)'