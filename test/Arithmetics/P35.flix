mod Arithmetics.P35 {
    use Arithmetics.primeFactors;

    @test
    def testPrimeFactors(): Bool =
        primeFactors(315) == 3 :: 3 :: 5 :: 7 :: Nil

}
