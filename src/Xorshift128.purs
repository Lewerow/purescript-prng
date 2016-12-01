module PRNG.Xorshift128 (Xorshift128, initialize, generate) where

import Prelude (($))
import Data.Array (index)
import Data.Maybe (fromMaybe)
import Data.Int.Bits ((.^.), zshr, shl)

-- | `Xorshift128` is a structure that holds state for Xorshift PRNG
-- | Xorshift algorithm is explained in https://en.wikipedia.org/wiki/Xorshift
-- | This is the version with maximal period 2^128 - 1
data Xorshift128 = Xorshift128 { x :: Int
  , y :: Int
  , z :: Int
  , w :: Int
}

defaultXValue :: Int
defaultXValue = 1
defaultYValue :: Int
defaultYValue = 1
defaultZValue :: Int
defaultZValue = 1
defaultWValue :: Int
defaultWValue = 1

-- | Creates a starting `Xorshift128` state from an array of `Int`
-- | There shall be four integers in the array - if there are more, additional ones
-- | will be discarded, but if there are fewer, default values will be used.
-- | Default values are not random (it's [1, 1, 1, 1]), so it's not recommended
initialize :: Array Int -> Xorshift128
initialize seeds =
  Xorshift128 { x : fromMaybe defaultXValue $ index seeds 0
    , y : fromMaybe defaultYValue $ index seeds 1
    , z : fromMaybe defaultZValue $ index seeds 2
    , w : fromMaybe defaultWValue $ index seeds 3
  }

-- | Excecute one step of Xorshift algorithm, return a record with
-- | generated pseudo-random value and new PRNG state
-- | note that this function is deterministic, so to get a sequence
-- | of psuedo-random numbers, you need to use the newest state for
-- | every new value (i.e., using same state twice will yield same numbers)
generate :: Xorshift128 -> { value :: Int, state :: Xorshift128 }
generate (Xorshift128 { x, y, z, w }) = { value: w2, state: newState}
  where
    t1 = x
    t2 = t1 .^. (shl t1 11)
    t3 = t2 .^. (zshr t2 8)
    x1 = y
    y1 = z
    z1 = w
    w1 = w .^. (zshr w 19)
    w2 = w1 .^. t3
    newState = Xorshift128 { x: x1, y: y1, z: z1, w: w2 }
