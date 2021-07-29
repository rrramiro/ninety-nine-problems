namespace Lists/P22 {
    use Lists.range;

    @test
    def testRange01(): Bool =
        range(4, 9) == 4 :: 5 :: 6 :: 7 :: 8 :: 9 :: Nil

}
