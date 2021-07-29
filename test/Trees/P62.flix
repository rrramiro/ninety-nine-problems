// Collect the leaves of a binary tree in a list
// A leaf is a node with no successors.
namespace Trees/P62 {

    @test
    def testinternals01(): Bool =
        Trees.internals(TNode(0, TNil, TNil)) == Nil

    @test
    def testinternals02(): Bool =
        Trees.internals(TNode(0, TNode(1, TNil, TNil), TNode(2, TNil, TNil))) == 0 :: Nil

    @test
    def testinternals03(): Bool =
        Trees.internals(TNode(0, TNode(0, TNil, TNil), TNode(1, TNode(2, TNil, TNil), TNode(3, TNil, TNil)))) == 0 :: 1 :: Nil

}
