## Module PRNG.Xorshift128

#### `Xorshift128`

``` purescript
data Xorshift128
```

`Xorshift128` is a structure that holds state for Xorshift PRNG.
Xorshift algorithm is explained in https://en.wikipedia.org/wiki/Xorshift.
This is the version with maximal period 2^128 - 1

Initialization behavior: First four values of the seed are used, rest is discarded.

Default seeds: [1, 1, 1, 1]

##### Instances
``` purescript
PRNG Xorshift128
```


