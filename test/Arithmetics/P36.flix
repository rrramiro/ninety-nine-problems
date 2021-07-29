namespace Arithmetics/P36 {
    use Arithmetics.primeFactorMultiplicity;

    @test
    def testPrimeFactorMultiplicity(): Bool =
        primeFactorMultiplicity(315) == (3, 2) :: (5, 1) :: (7, 1) :: Nil

}
