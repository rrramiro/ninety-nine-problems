// Layout a binary tree
namespace Trees/P64 {

    @test
    def testLayoutBinaryTree01(): Bool =
        Trees.layoutBinaryTree(TNode("a", TNode("b", TNil, TNode("c", TNil, TNil)), TNode("d", TNil, TNil))) ==
            TNode(Positioned("a", 3, 1), TNode(Positioned("b", 1, 2), TNil, TNode(Positioned("c", 2, 3), TNil, TNil)), TNode(Positioned("d", 4, 2), TNil, TNil))
//  a
//b  d
// c
    @test
    def testLayoutBinaryTree02(): Bool =
        Trees.layoutBinaryTree(
            Trees.fromList("n" :: "k" :: "m" :: "c" :: "a" :: "h" :: "g" :: "e" :: "u" :: "p" :: "s" :: "q" :: Nil)
        ) == TNode(Positioned("n", 8, 1), TNode(Positioned("k", 6, 2), TNode(Positioned("c", 2, 3), TNode(Positioned("a", 1, 4), TNil, TNil), TNode(Positioned("h", 5, 4), TNode(Positioned("g", 4, 5), TNode(Positioned("e", 3, 6), TNil, TNil), TNil), TNil)), TNode(Positioned("m", 7, 3), TNil, TNil)), TNode(Positioned("u", 12, 2), TNode(Positioned("p", 9, 3), TNil, TNode(Positioned("s", 11, 4), TNode(Positioned("q", 10, 5), TNil, TNil), TNil)), TNil))

//       n
//     k     u
//  c   m p
//a   h     s
//   g     q
//  e
}
