module Test.Main where

import Test.Unit.Main (runTest)
import Test.Xorshift128 as Xorshift

main = runTest do
  Xorshift.all
