// Collect the leaves of a binary tree in a list
// A leaf is a node with no successors.
mod Trees.P62 {

    @test
    def testinternals01(): Bool =
        Trees.internals(Tree.TNode(0, Tree.TNil, Tree.TNil)) == Nil

    @test
    def testinternals02(): Bool =
        Trees.internals(Tree.TNode(0, Tree.TNode(1, Tree.TNil, Tree.TNil), Tree.TNode(2, Tree.TNil, Tree.TNil))) == 0 :: Nil

    @test
    def testinternals03(): Bool =
        Trees.internals(Tree.TNode(0, Tree.TNode(0, Tree.TNil, Tree.TNil), Tree.TNode(1, Tree.TNode(2, Tree.TNil, Tree.TNil), Tree.TNode(3, Tree.TNil, Tree.TNil)))) == 0 :: 1 :: Nil

}
