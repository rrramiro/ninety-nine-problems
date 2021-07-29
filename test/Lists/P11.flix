namespace Lists/P11 {
    use Lists.encodeModified;
    use Lists.EncodeResult.{Single, Multiple};
    @test
    def testEncodeModified01(): Bool =
        encodeModified("a" :: "a" :: "a" :: "a" :: "b" :: "c" :: "c" :: "a" :: "a" :: "d" :: "e" :: "e" :: "e" :: "e" :: Nil) == (
            Multiple(4, "a") ::
            Single("b") ::
            Multiple(2, "c") ::
            Multiple(2, "a") ::
            Single("d") ::
            Multiple(4, "e") :: Nil
        )

}
