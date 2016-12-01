module PRNG.Xorshift128 where

import Prelude
import Data.Array (index)
import Data.Maybe (fromMaybe)
import Data.Int.Bits ((.^.), zshr, shl)

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

initialize :: Array Int -> Xorshift128
initialize seeds =
  Xorshift128 { x : fromMaybe defaultXValue $ index seeds 0
    , y : fromMaybe defaultYValue $ index seeds 1
    , z : fromMaybe defaultZValue $ index seeds 2
    , w : fromMaybe defaultWValue $ index seeds 3
  }

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
