mod Lists.P23 {
    @test
    pub def testRandomSelect01(): Bool =
        let result = Random.runWithSeed(
            123456i64,
            () -> Randoms.randomSelect(3, "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: "g" :: Nil)
        );
        result ==  "b" :: "d" :: "c" :: Nil

}
