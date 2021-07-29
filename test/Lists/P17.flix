namespace Lists/P17 {
    use Lists.split;

    @test
    def testSplit01(): Bool =
        split(3, "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: "g" :: "h" :: "i" :: "j" :: "k" :: Nil) == (
            ("a" :: "b" :: "c" :: Nil),
            ("d" :: "e" :: "f" :: "g" :: "h" :: "i" :: "j" :: "k" :: Nil)
        )

}
