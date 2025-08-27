mod Lists.P16 {
    use Lists.drop;

    @test
    def testDrop01(): Bool =
          drop(3, "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: "g" :: "h" :: "i" :: "j" :: "k" :: Nil) ==
              "a" :: "b" :: "d" :: "e" :: "g" :: "h" :: "j" :: "k" :: Nil

    @test
    def testDrop02(): Bool =
        drop(5, "a" :: "b" :: "c" :: "d" :: Nil) ==
            "a" :: "b" :: "c" :: "d" :: Nil

}
