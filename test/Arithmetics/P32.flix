namespace Arithmetics/P32 {
    use Arithmetics.gcd;

    @test
    def testGCD01(): Bool =
        gcd(36, 63) == 9

}
