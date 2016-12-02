module PRNG.LehmerRNG where

import Data.Array (fromFoldable, index)
import Data.Foldable (class Foldable)
import Data.Maybe (maybe)
import Prelude (($), (+), (-), (*), (>), mod, div)
import Data.UInt (UInt, toInt, fromInt, pow)


data LehmerRNG = LehmerRNG UInt

defaultSeed :: UInt
defaultSeed = fromInt 1

initialize :: forall f. Foldable f => f Int -> LehmerRNG
initialize fseeds = LehmerRNG $ maybe defaultSeed fromInt $ index seeds 0
    where seeds = fromFoldable fseeds

m :: UInt
m = (pow (fromInt 2) (fromInt 31)) - (fromInt 1) -- Mersenne's prime
a :: UInt
a = fromInt 16807 -- prime root of m
q :: UInt
q = m `div` a
r :: UInt
r = m `mod` a

generate :: LehmerRNG -> { value :: Int, state :: LehmerRNG }
generate (LehmerRNG seed) = { value: val, state: LehmerRNG rnd}
  where
    hi = seed `div` q
    lo = seed `mod` q
    res = a * lo - r * hi
    rnd = if res > (fromInt 0) then res else res + m
    val = toInt rnd
