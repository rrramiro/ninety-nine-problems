mod Lists.P13 {
    use Lists.encodeDirect;
    @test
    def testEncode01(): Bool =
        encodeDirect("a" :: "a" :: "a" :: "a" :: "b" :: "c" :: "c" :: "a" :: "a" :: "d" :: "e" :: "e" :: "e" :: "e" :: Nil) == (
            (4, "a") ::
            (1, "b") ::
            (2, "c") ::
            (2, "a") ::
            (1, "d") ::
            (4, "e") :: Nil
        )

}
