## Module PRNG.Xorshift128

#### `Xorshift128`

``` purescript
data Xorshift128
```

`Xorshift128` is a structure that holds state for Xorshift PRNG
Xorshift algorithm is explained in https://en.wikipedia.org/wiki/Xorshift
This is the version with maximal period 2^128 - 1

#### `initialize`

``` purescript
initialize :: forall f. Foldable f => f Int -> Xorshift128
```

Creates a starting `Xorshift128` state from an array of `Int`
There shall be four integers in the array - if there are more, additional ones
will be discarded, but if there are fewer, default values will be used.
Default values are not random (it's [1, 1, 1, 1]), so it's not recommended
Seed values shall be random, e.g. received from `Control.Monad.Eff.Random`

For example:
``` purescript
seeds <- replicateM 4 (Random.randomInt -100000000 100000000)
generateNumbers (initialize seeds)
```

#### `generate`

``` purescript
generate :: Xorshift128 -> { value :: Int, state :: Xorshift128 }
```

Excecute one step of Xorshift algorithm, return a record with
generated pseudo-random value and new PRNG state
note that this function is deterministic, so to get a sequence
of psuedo-random numbers, you need to use the newest state for
every new value (i.e., using same state twice will yield same numbers)

Example:
``` purescript

```


