mod Lists.P24 {
    use Lists.P23.randomSelect;
    def lotto(gen: Int32 -> Int32 \ Random, count: Int32, max: Int32): List[Int32] \ Random=
        randomSelect(gen, count, List.range(1, max + 1))

    @test
    def testLotto01(): Bool = 
        let result = Random.runWithSeed(123456i64, 
            () -> {
                let gen = Randoms.nextInt;
                lotto(gen, 6, 49) 
            }
        );
        result == 2 :: 16 :: 41 :: 48 :: 14 :: 9 :: Nil
}
