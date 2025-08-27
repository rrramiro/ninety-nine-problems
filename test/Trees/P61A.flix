// Collect the leaves of a binary tree in a list
// A leaf is a node with no successors.
mod Trees.P61A {

    @test
    def testleaves01(): Bool =
        Trees.leaves(Tree.TNode(0, Tree.TNil, Tree.TNil)) == 0 :: Nil

    @test
    def testleaves02(): Bool =
        Trees.leaves(Tree.TNode(0, Tree.TNode(1, Tree.TNil, Tree.TNil), Tree.TNode(2, Tree.TNil, Tree.TNil))) == 1 :: 2 :: Nil

    @test
    def testleaves03(): Bool =
        Trees.leaves(Tree.TNode(0, Tree.TNode(0, Tree.TNil, Tree.TNil), Tree.TNode(1, Tree.TNode(2, Tree.TNil, Tree.TNil), Tree.TNode(3, Tree.TNil, Tree.TNil)))) == 0 :: 2 :: 3 :: Nil

}
