mod Lists.P24 {
    def lotto(count: Int32, max: Int32): List[Int32] \ Random=
        Randoms.randomSelect(count, List.range(1, max + 1))

    @test
    pub def testLotto01(): Bool =
        let result = Random.runWithSeed(
            123456i64,
            () -> lotto(6, 49)
        );
        result == 2 :: 16 :: 41 :: 48 :: 14 :: 9 :: Nil
}
