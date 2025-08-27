mod Arithmetics.P39 {
    use Arithmetics.primesInRange;

    @test
    def testPrimesInRange(): Bool =
        primesInRange(7, 31) == 7 :: 11 :: 13 :: 17 :: 19 :: 23 :: 29 :: 31 :: Nil

}
