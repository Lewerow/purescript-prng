# purescript-prng

## Introduction

Pseudo-random numbers are deterministic functions, used to simulate random
number generation. Decades of statistical research was done to create reasonable
tests for randomness, and more details about the idea can be found at https://en.wikipedia.org/wiki/Pseudorandom_number_generator

This library provides a type class for pseudo-random number generators (PRNGs) similar to
Haskell's `System.Random.RandomGen` class, but simplified (range is always full `Int` range,
no `split` function provided for multiplicating number of PRNGs).

None of the implemented generators is a cryptographically-secure PRNG. If you need one,
you can either roll out your own, bind to JS via FFI or at least let me know that you
need it via GitHub issues.

It is probable that this implementation is not very efficient - it uses bitwise operations
bound to JavaScript via FFI, which may cause a lot of overheard (for creating unary functions etc.).

## Installation
```
bower install purescript-prng
```

## Documentation
Module API documentation is [published on Pursuit](http://pursuit.purescript.org/packages/purescript-prng).
