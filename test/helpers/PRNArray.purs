module Test.Helpers.PRNArray where

import Prelude ((-))
import Data.Array ((:))

import PRNG.PRNG

prnArray :: forall a. PRNG a => Int -> a -> Array Int
prnArray 0 _ = []
prnArray x gen = rnd.value : prnArray (x - 1) rnd.state
  where
  rnd = generate gen
