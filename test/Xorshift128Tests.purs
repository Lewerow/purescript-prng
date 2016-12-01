module MersenneTwisterTests where

import Prelude
import Test.Unit (suite, test)
import Test.Unit.Assert as Assert

import PRNG.Xorshift128 as Xorshift

generator = Xorshift.initialize [0, 0, 0, 0]

all =suite "Xorshift128+ " do
  test "For seed 1" do
    Assert.assert "first value is valid" $ v1.value == 1791095845
    Assert.assert "second value is valid" $ v2.value == (-12091157)
    where
    v1 = Xorshift.generate generator
    v2 = Xorshift.generate v1.state
