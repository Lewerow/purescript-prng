module PRNG.LehmerRNG (LehmerRNG) where

import Data.Array (fromFoldable, index)
import Data.Maybe (maybe)
import Data.UInt (UInt, toInt, fromInt, pow)
import Prelude (($), (+), (-), (*), (>), mod, div)

import PRNG.PRNG (class PRNG)

-- | `LehmerRNG` is a structure that holds state for Lehmer PRNG, aka Park-Miller RNG, aka MINSTD
-- | Lehmer algorithm is explained in https://en.wikipedia.org/wiki/Lehmer_random_number_generator.
-- | This is the version with A=16807, i.e., the original one (C++11 has A=48271, a revised number)
data LehmerRNG = LehmerRNG UInt

defaultSeed :: UInt
defaultSeed = fromInt 1

m :: UInt
m = (pow (fromInt 2) (fromInt 31)) - (fromInt 1) -- Mersenne's prime
a :: UInt
a = fromInt 16807 -- prime root of m
q :: UInt
q = m `div` a
r :: UInt
r = m `mod` a

instance lehmerPRNG :: PRNG LehmerRNG where
  -- | First value of the seed is used, rest is discarded.
  -- | Default seed is 1
  initialize fseeds = LehmerRNG $ maybe defaultSeed fromInt $ index seeds 0
    where seeds = fromFoldable fseeds

  generate (LehmerRNG seed) = { value: val, state: LehmerRNG rnd}
    where
      hi = seed `div` q
      lo = seed `mod` q
      res = a * lo - r * hi
      rnd = if res > (fromInt 0) then res else res + m
      val = toInt rnd
