// Count the leaves of a binary tree
// A leaf is a node with no successors.
mod Trees.P61 {

    @test
    def testLeafs01(): Bool =
        Trees.leafs(Tree.TNode(0, Tree.TNil, Tree.TNil)) == 1

    @test
    def testLeafs02(): Bool =
        Trees.leafs(Tree.TNode(0, Tree.TNode(1, Tree.TNil, Tree.TNil), Tree.TNode(2, Tree.TNil, Tree.TNil))) == 2

    @test
    def testLeafs03(): Bool =
        Trees.leafs(Tree.TNode(0, Tree.TNode(0, Tree.TNil, Tree.TNil), Tree.TNode(1, Tree.TNode(2, Tree.TNil, Tree.TNil), Tree.TNode(3, Tree.TNil, Tree.TNil)))) == 3

}
