mod Lists.P15 {
    use Lists.duplicateN;
    @test
    def testDuplicateN01(): Bool =
        duplicateN(3, "a" :: "b" :: "c" :: "c" :: "d" :: Nil) ==
            "a" :: "a" :: "a" :: "b" :: "b" :: "b" :: "c" :: "c" :: "c" :: "c" :: "c" :: "c" :: "d" :: "d" :: "d" :: Nil
}
