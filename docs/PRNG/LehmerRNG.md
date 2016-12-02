## Module PRNG.LehmerRNG

#### `LehmerRNG`

``` purescript
data LehmerRNG
```

`LehmerRNG` is a structure that holds state for Lehmer PRNG, aka Park-Miller RNG, aka MINSTD
Lehmer algorithm is explained in https://en.wikipedia.org/wiki/Lehmer_random_number_generator.
This is the version with A=16807, i.e., the original one (C++11 has A=48271, a revised number)

Initialization behavior: First value of the seed are used, rest is discarded.

Default seed: 1

##### Instances
``` purescript
PRNG LehmerRNG
```


