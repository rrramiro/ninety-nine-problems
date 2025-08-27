mod Arithmetics.P31 {
    use Arithmetics.isPrime;

    @test
    def testIsPrime01(): Bool =
        isPrime(6) == false

    @test
    def testIsPrime02(): Bool =
        isPrime(4) == false

    @test
    def testIsPrime03(): Bool =
        isPrime(5) == true

}
