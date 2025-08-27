mod Arithmetics.P34 {
    use Arithmetics.totient;

    @test
    def testTotient(): Bool =
        totient(10) == 4

}
