namespace Lists/P26 {
    use Lists.combinations;

    @test
    def testCombinations01(): Bool =
        let c1 = combinations(1, "a" :: "b" :: "c" :: Nil);
        let a1 = ("a" :: Nil) :: ("b" :: Nil) :: ("c" :: Nil) :: Nil;
        List.length(c1) == List.length(a1) and List.toSet(c1) == List.toSet(a1)

    @test
    def testCombinations02(): Bool =
        let c2 = combinations(2, "a" :: "b" :: "c" :: Nil);
        let a2 = (
            ("a" :: "b" :: Nil) ::
            ("a" :: "c" :: Nil) ::
            ("b" :: "c" :: Nil) :: Nil
        );
        List.length(c2) == List.length(a2) and List.toSet(c2) == List.toSet(a2)

    @test
    def testCombinations03(): Bool =
        let c3 = combinations(3, "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: Nil);
        let a3 = (
            ("a" :: "b" :: "c" :: Nil) ::
            ("a" :: "b" :: "d" :: Nil) ::
            ("a" :: "b" :: "e" :: Nil) ::
            ("a" :: "b" :: "f" :: Nil) ::
            ("a" :: "c" :: "d" :: Nil) ::
            ("a" :: "c" :: "e" :: Nil) ::
            ("a" :: "c" :: "f" :: Nil) ::
            ("a" :: "d" :: "e" :: Nil) ::
            ("a" :: "d" :: "f" :: Nil) ::
            ("a" :: "e" :: "f" :: Nil) ::
            ("b" :: "c" :: "d" :: Nil) ::
            ("b" :: "c" :: "e" :: Nil) ::
            ("b" :: "c" :: "f" :: Nil) ::
            ("b" :: "d" :: "e" :: Nil) ::
            ("b" :: "d" :: "f" :: Nil) ::
            ("b" :: "e" :: "f" :: Nil) ::
            ("c" :: "d" :: "e" :: Nil) ::
            ("c" :: "d" :: "f" :: Nil) ::
            ("c" :: "e" :: "f" :: Nil) ::
            ("d" :: "e" :: "f" :: Nil) :: Nil
        );
        List.length(c3) == List.length(a3) and List.toSet(c3) == List.toSet(a3)

}
