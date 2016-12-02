module Test.Main where

import Prelude (bind)

import Test.Unit.Main (runTest)
import Test.Unit (suite)
import Test.Xorshift128 as Xorshift
import Test.LehmerRNG as Lehmer

main = runTest do
  suite "All" do
    Xorshift.all
    Lehmer.all
