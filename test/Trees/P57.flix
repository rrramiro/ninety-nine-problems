mod Trees.P57 {

    @test
    def testInsert01(): Bool =
        Trees.insert("a", Tree.TNil) == Tree.TNode("a", Tree.TNil, Tree.TNil)

    @test
    def testInsert02(): Bool =
        (Tree.TNil |> Trees.insert(2) |> Trees.insert(3) |> Trees.insert(0)) == Tree.TNode(2, Tree.TNode(0, Tree.TNil, Tree.TNil), Tree.TNode(3, Tree.TNil, Tree.TNil))

    @test
    def testFromList01(): Bool =
        Trees.fromList(3 :: 2 :: 5 :: 7 :: 1 :: Nil) == Tree.TNode(3, Tree.TNode(2, Tree.TNode(1, Tree.TNil, Tree.TNil), Tree.TNil), Tree.TNode(5, Tree.TNil, Tree.TNode(7, Tree.TNil, Tree.TNil)))

    @test
    def testFromList02(): Bool =
        Trees.fromList(5 :: 3 :: 18 :: 1 :: 4 :: 12 :: 21 :: Nil) |> Trees.isSymmetric

    @test
    def testFromList03(): Bool =
        not (Trees.fromList(3 :: 2 :: 5 :: 7 :: 4 :: Nil) |> Trees.isSymmetric)
}
