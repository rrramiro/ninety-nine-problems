mod Lists.P19 {
    use Lists.rotate;
    @test
    def testRotate01(): Bool =
        rotate(3, "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: "g" :: "h" :: "i" :: "j" :: "k" :: Nil) ==
            "d" :: "e" :: "f" :: "g" :: "h" :: "i" :: "j" :: "k" :: "a" :: "b" :: "c" :: Nil

    @test
    def testRotate02(): Bool =
        rotate(-2, "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: "g" :: "h" :: "i" :: "j" :: "k" :: Nil) ==
            "j" :: "k" :: "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: "g" :: "h" :: "i" :: Nil

}
