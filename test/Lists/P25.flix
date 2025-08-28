mod Lists.P25 {
    @test
    pub def testRandomPermute01(): Bool =
        let initial = "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: Nil;
        let result = Random.runWithSeed(
            123456i64,
            () -> Randoms.randomPermute(initial)
        );
        result == "b" :: "c" :: "f" :: "e" :: "d" :: "a" :: Nil

}
