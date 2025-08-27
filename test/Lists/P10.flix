// Run-length encoding of a list.
mod Lists.P10 {
    use Lists.encode;
    @test
    def testEncode01(): Bool =
        encode("a" :: "a" :: "a" :: "a" :: "b" :: "c" :: "c" :: "a" :: "a" :: "d" :: "e" :: "e" :: "e" :: "e" :: Nil) == (
            (4, "a") ::
            (1, "b") ::
            (2, "c") ::
            (2, "a") ::
            (1, "d") ::
            (4, "e") :: Nil
        )

}
