// Construct a complete binary tree.
namespace Trees/P63 {

    @test
    def testCompleteBinaryTree01(): Bool =
        Trees.completeBinaryTree(6, "x") == TNode(
            "x",
            TNode("x", TNode("x", TNil, TNil), TNode("x", TNil, TNil)),
            TNode("x", TNode("x", TNil, TNil), TNil)
        )
}
