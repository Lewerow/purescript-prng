module Test.Main where

import Test.Unit.Main (runTest)
import Xorshift128Tests as Xorshift

main = runTest do
  Xorshift.all
