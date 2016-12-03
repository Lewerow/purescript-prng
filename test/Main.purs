module Test.Main where

import Test.LehmerRNG as Lehmer
import Test.Xorshift128 as Xorshift
import Prelude (bind)
import Test.Unit (suite)
import Test.Unit.Main (runTest)

main = runTest do
  suite "All" do
    Xorshift.all
    Lehmer.all
