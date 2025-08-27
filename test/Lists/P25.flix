mod Lists.P25 {
    use Lists.P23.randomSelect;
    def randomPermute(gen: Int32 -> Int32 \ Random, l: List[a]): List[a] \ Random =
        randomSelect(gen, List.length(l), l)

    @test
    def testRandomPermute01(): Bool =
        let result = Random.runWithSeed(123456i64, 
            () -> {
                let gen = Randoms.nextInt;
                randomPermute(gen, "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: Nil)
            }
        );
        result == "b" :: "c" :: "a" :: "d" :: Nil

}
