mod Arithmetics.P33 {
    use Arithmetics.isCoprimeTo;

    @test
    def testIsCoprimeTo01(): Bool =
        isCoprimeTo(35, 64) == true

    @test
    def testIsCoprimeTo02(): Bool =
        isCoprimeTo(64, 35) == true

    @test
    def testIsCoprimeTo03(): Bool =
        isCoprimeTo(35, 65) == false

    @test
    def testIsCoprimeTo04(): Bool =
        isCoprimeTo(65, 35) == false

}
