## Module PRNG.PRNG

#### `PRNG`

``` purescript
class PRNG a where
  initialize :: forall f. Foldable f => f Int -> a
  generate :: a -> { value :: Int, state :: a }
```

This is a class for Psedo-Random Number Generators
it has to provide an initialization routine and a generation function.

Since PRNGs are deterministic and PureScript is Pure (no internal state),
new generator state has to be returned as second value from generation call

For intialization each algorithm provides default values in case of empty Foldable, but it is recommended not to use them.
Default values are not random, so you have to to pass all seed elements.
Seed values shall be random, e.g., received from `Control.Monad.Eff.Random`
Or some different source of entropy, like an external service (random.org or others)
Details of the initialization and requirements will depend on used algorithm.
In particular, number of used elements will heavily depend on chosen algorithm.
If you pass in less elements than required, default values will be used for the
rest of the seed, but if you pass in more, either all may be used (reduced to seed)
or additional ones may be dropped - this is defined on a per-algorithm basis.
Avoid infinite lists as seeds, as they might cause infinite recursion during reduction.

Example of usage:

``` purescript
seeds <- replicateM 4 (Random.randomInt -100000000 100000000)
pure $ (generate $ initialize seeds)
```


