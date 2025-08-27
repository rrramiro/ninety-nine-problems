// Construct a complete binary tree.
mod Trees.P63 {

    @test
    def testCompleteBinaryTree01(): Bool =
        Trees.completeBinaryTree(6, "x") == Tree.TNode(
            "x",
            Tree.TNode("x", Tree.TNode("x", Tree.TNil, Tree.TNil), Tree.TNode("x", Tree.TNil, Tree.TNil)),
            Tree.TNode("x", Tree.TNode("x", Tree.TNil, Tree.TNil), Tree.TNil)
        )
}
