// Collect the leaves of a binary tree in a list
// A leaf is a node with no successors.
namespace Trees/P61A {

    @test
    def testleaves01(): Bool =
        Trees.leaves(TNode(0, TNil, TNil)) == 0 :: Nil

    @test
    def testleaves02(): Bool =
        Trees.leaves(TNode(0, TNode(1, TNil, TNil), TNode(2, TNil, TNil))) == 1 :: 2 :: Nil

    @test
    def testleaves03(): Bool =
        Trees.leaves(TNode(0, TNode(0, TNil, TNil), TNode(1, TNode(2, TNil, TNil), TNode(3, TNil, TNil)))) == 0 :: 2 :: 3 :: Nil

}
