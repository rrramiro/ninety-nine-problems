namespace Lists/P20 {
    use Lists.removeAt;

    @test
    def testRemoveAt01(): Bool =
        removeAt(1, "a" :: "b" :: "c" :: "d" :: Nil) ==
            ("a" :: "c" :: "d" :: Nil, Some("b"))

}
