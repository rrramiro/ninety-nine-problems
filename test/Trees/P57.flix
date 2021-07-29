namespace Trees/P57 {

    @test
    def testInsert01(): Bool =
        Trees.insert("a", TNil) == TNode("a", TNil, TNil)

    @test
    def testInsert02(): Bool =
        (TNil |> Trees.insert(2) |> Trees.insert(3) |> Trees.insert(0)) == TNode(2, TNode(0, TNil, TNil), TNode(3, TNil, TNil))

    @test
    def testFromList01(): Bool =
        Trees.fromList(3 :: 2 :: 5 :: 7 :: 1 :: Nil) == TNode(3, TNode(2, TNode(1, TNil, TNil), TNil), TNode(5, TNil, TNode(7, TNil, TNil)))

    @test
    def testFromList02(): Bool =
        Trees.fromList(5 :: 3 :: 18 :: 1 :: 4 :: 12 :: 21 :: Nil) |> Trees.isSymmetric

    @test
    def testFromList03(): Bool =
        not (Trees.fromList(3 :: 2 :: 5 :: 7 :: 4 :: Nil) |> Trees.isSymmetric)
}
