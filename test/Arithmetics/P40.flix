namespace Arithmetics/P40 {
    use Arithmetics.goldbach;

    @test
    def testGoldbach(): Bool =
        goldbach(28) == Some((5,23))

}
