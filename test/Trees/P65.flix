// Layout a binary tree
namespace Trees/P65 {

    @test
    def testLayoutBinaryTree201(): Bool =
        Trees.layoutBinaryTree2(
            TNode("a", TNode("b", TNil, TNode("c", TNil, TNil)), TNode("d", TNil, TNil))
        ) == TNode(Positioned("a", 3, 1), TNode(Positioned("b", 1, 2), TNil, TNode(Positioned("c", 2, 3), TNil, TNil)), TNode(Positioned("d", 5, 2), TNil, TNil))


//  a
//b   d
// c
    @test
    def testLayoutBinaryTree202(): Bool =
        Trees.layoutBinaryTree2(
            Trees.fromList("n" :: "k" :: "m" :: "c" :: "a" :: "e" :: "d" :: "g" :: "u" :: "p" :: "q" :: Nil)
        ) == TNode(Positioned("n", 15, 1), TNode(Positioned("k", 7, 2), TNode(Positioned("c", 3, 3), TNode(Positioned("a", 1, 4), TNil, TNil), TNode(Positioned("e", 5, 4), TNode(Positioned("d", 4, 5), TNil, TNil), TNode(Positioned("g", 6, 5), TNil, TNil))), TNode(Positioned("m", 11, 3), TNil, TNil)), TNode(Positioned("u", 23, 2), TNode(Positioned("p", 19, 3), TNil, TNode(Positioned("q", 21, 4), TNil, TNil)), TNil))


//              n
//      k               u
//  c       m       p
//a   e               q
//   d g
}
