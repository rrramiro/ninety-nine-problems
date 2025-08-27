//Construct completely balanced binary trees
mod Trees.P55 {
    //import Trees.Tree.*

    @test
    def testcBalanced01(): Bool =
        Trees.cBalanced(2, "x") == Tree.TNode("x", Tree.TNil, Tree.TNode("x", Tree.TNil, Tree.TNil)) :: Tree.TNode("x", Tree.TNode("x", Tree.TNil, Tree.TNil), Tree.TNil) :: Nil

    @test
    def testcBalanced02(): Bool =
        Trees.cBalanced(3, "x") == Tree.TNode("x", Tree.TNode("x", Tree.TNil, Tree.TNil), Tree.TNode("x", Tree.TNil, Tree.TNil)) :: Nil

    @test
    def testcBalanced03(): Bool =
        Trees.cBalanced(4, "x") == (
            Tree.TNode("x",
                Tree.TNode("x", Tree.TNil, Tree.TNil),
                Tree.TNode("x", Tree.TNil,
                    Tree.TNode("x", Tree.TNil,Tree.TNil)
                )
            ) ::
            Tree.TNode("x",
                Tree.TNode("x", Tree.TNil,
                    Tree.TNode("x", Tree.TNil, Tree.TNil)
                ),
                Tree.TNode("x", Tree.TNil, Tree.TNil)
            ) ::
            Tree.TNode("x",
                Tree.TNode("x", Tree.TNil, Tree.TNil),
                Tree.TNode("x",
                    Tree.TNode("x", Tree.TNil, Tree.TNil),
                    Tree.TNil
                )
            ) ::
            Tree.TNode("x",
                Tree.TNode("x",
                    Tree.TNode("x", Tree.TNil, Tree.TNil),
                    Tree.TNil
                ),
                Tree.TNode("x", Tree.TNil, Tree.TNil)
            ) :: Nil
        )

    @test
    def testcBalanced04(): Bool \ IO =
        let actual = Trees.cBalanced(40, "x");
        println(List.length(actual));
        List.length(actual) == 524288

}
