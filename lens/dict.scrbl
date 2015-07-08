#lang scribble/manual

@(require scribble/eval
          "lenses-examples.rkt"
          (for-label lens
                     racket/base
                     racket/contract))


@title{Dict lenses}

@defproc[(dict-ref-lens [key any/c]) lens?]{
  Returns a lens for viewing the value mapped to @racket[key] in a dict.
  @lenses-examples[
    (define dict '((a . 1) (b . 2) (c . 3)))
    (lens-view (dict-ref-lens 'a) dict)
    (lens-set (dict-ref-lens 'a) dict 100)
]}