namespace Lists/P18 {
    use Lists.slice;

    @test
    def tesSlice01(): Bool =
        slice(3, 7, "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: "g" :: "h" :: "i" :: "j" :: "k":: Nil) ==
            "d" :: "e" :: "f" :: "g" :: Nil
}
