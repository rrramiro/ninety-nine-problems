mod Lists.P21 {
    use Lists.insertAt;
    @test
    def testInsertAt01(): Bool =
        insertAt("new", 1, "a" :: "b" :: "c" :: "d" :: Nil) == "a" :: "new" :: "b" :: "c" :: "d" :: Nil

}
