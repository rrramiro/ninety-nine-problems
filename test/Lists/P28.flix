namespace Lists/P28 {
    def lsort(l: List[List[a]]): List[List[a]] = List.sortBy(x -> List.length(x) , l) //TODO

    @test
    def testLsort01(): Bool =
        lsort(
            (
                ("a" :: "b" :: "c" :: Nil) ::
                ("d" :: "e" :: Nil) ::
                ("f" :: "g" :: "h" :: Nil) ::
                ("d" :: "e" :: Nil) ::
                ("i" :: "j" :: "k" :: "l" :: Nil) ::
                ("m" :: "n" :: Nil) ::
                ("o" :: Nil) :: Nil
            )
        ) == (
            ("o" :: Nil) ::
            ("m" :: "n" :: Nil) ::
            ("d" :: "e" :: Nil) ::
            ("d" :: "e" :: Nil) ::
            ("a" :: "b" :: "c" :: Nil) ::
            ("f" :: "g" :: "h" :: Nil) ::
            ("i" :: "j" :: "k" :: "l" :: Nil) :: Nil
        )

}
