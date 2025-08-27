mod Lists.P14 {
    use Lists.duplicate;
    @test
    def testDuplicate01(): Bool =
        duplicate("a" :: "b" :: "c" :: "c" :: "d" :: Nil) ==
            "a" :: "a" :: "b" :: "b" :: "c" :: "c" :: "c" :: "c" :: "d" :: "d" :: Nil
}
