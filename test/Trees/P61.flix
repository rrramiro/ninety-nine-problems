// Count the leaves of a binary tree
// A leaf is a node with no successors.
namespace Trees/P61 {

    @test
    def testLeafs01(): Bool =
        Trees.leafs(TNode(0, TNil, TNil)) == 1

    @test
    def testLeafs02(): Bool =
        Trees.leafs(TNode(0, TNode(1, TNil, TNil), TNode(2, TNil, TNil))) == 2

    @test
    def testLeafs03(): Bool =
        Trees.leafs(TNode(0, TNode(0, TNil, TNil), TNode(1, TNode(2, TNil, TNil), TNode(3, TNil, TNil)))) == 3

}
