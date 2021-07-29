namespace Lists/P12 {
    use Lists.decode;
    @test
    def testDecode01(): Bool =
        decode(
            (4, "a") ::
            (1, "b") ::
            (2, "c") ::
            (2, "a") ::
            (1, "d") ::
            (4, "e") :: Nil
        ) == "a" :: "a" :: "a" :: "a" :: "b" :: "c" :: "c" :: "a" :: "a" :: "d" :: "e" :: "e" :: "e" :: "e" :: Nil

}
