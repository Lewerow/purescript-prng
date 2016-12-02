module PRNG.PRNG (class PRNG, initialize, generate) where

import Data.Foldable (class Foldable)

class PRNG a where
-- | Creates a starting state for the algorithm from a Foldable of `Int` (for example an `Array` or a `List`)
-- |
-- | Each algorithm provides default values in case of empty Foldable, but it is recommended not to use them.
-- | Default values are not random, so you have to to pass all seed elements.
-- | Seed values shall be random, e.g., received from `Control.Monad.Eff.Random`
-- | Or some different source of entropy, like an external service (random.org or others)
-- | Details of the initialization and requirements will depend on used algorithm.
-- | In particular, number of used elements will heavily depend on chosen algorithm.
-- | If you pass in less elements than required, default values will be used for the
-- | rest of the seed, but if you pass in more, either all may be used (reduced to seed)
-- | or additional ones may be dropped - this is defined on a per-algorithm basis.
-- | Avoid infinite lists as seeds, as they might cause infinite recursion during reduction.
-- |
-- | Example of usage:
-- |
-- | ``` purescript
-- | seeds <- replicateM 4 (Random.randomInt -100000000 100000000)
-- | pure $ initialize seeds
-- | ```
  initialize :: forall f. Foldable f => f Int -> a

  -- | Excecute one step of the algorithm, return a record with
  -- | generated pseudo-random value and new PRNG state.
  -- |
  -- | Note that this function is deterministic, so to get a sequence
  -- | of pseudo-random numbers, you need to use the newest state for
  -- | every new value (i.e., using same state twice will yield same numbers).
  -- |
  -- | Example of usage:
  -- |
  -- | ``` purescript
  -- | state = initialize [1, 2, 3, 4]
  -- | x = generate state
  -- | y = generate x.state
  -- | ```
  generate :: a -> { value :: Int, state :: a }
