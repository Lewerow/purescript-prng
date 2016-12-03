module PRNG.Xorshift128 (Xorshift128, module PRNG.PRNG) where

import Data.Foldable (class Foldable)
import Data.Array (fromFoldable, index)
import Data.Int.Bits ((.^.), zshr, shl)
import Data.Maybe (fromMaybe)
import Prelude (($))

import PRNG.PRNG (class PRNG)

-- | `Xorshift128` is a structure that holds state for Xorshift PRNG.
-- | Xorshift algorithm is explained in https://en.wikipedia.org/wiki/Xorshift.
-- | This is the version with maximal period 2^128 - 1
-- |
-- | Initialization behavior: First four values of the seed are used, rest is discarded.
-- |
-- | Default seeds: [1, 1, 1, 1]
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

instance xorshift128PRNG :: PRNG Xorshift128 where
  initialize fseeds =
    Xorshift128 { x : fromMaybe defaultXValue $ index seeds 0
      , y : fromMaybe defaultYValue $ index seeds 1
      , z : fromMaybe defaultZValue $ index seeds 2
      , w : fromMaybe defaultWValue $ index seeds 3
    }
    where seeds = fromFoldable fseeds

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
