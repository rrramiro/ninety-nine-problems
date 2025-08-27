// Layout a binary tree
mod Trees.P65 {

    @test
    def testLayoutBinaryTree201(): Bool =
        Trees.layoutBinaryTree2(
            Tree.TNode("a", Tree.TNode("b", Tree.TNil, Tree.TNode("c", Tree.TNil, Tree.TNil)), Tree.TNode("d", Tree.TNil, Tree.TNil))
        ) == Tree.TNode(Positioned.Positioned("a", 3, 1), Tree.TNode(Positioned.Positioned("b", 1, 2), Tree.TNil, Tree.TNode(Positioned.Positioned("c", 2, 3), Tree.TNil, Tree.TNil)), Tree.TNode(Positioned.Positioned("d", 5, 2), Tree.TNil, Tree.TNil))


//  a
//b   d
// c
    @test
    def testLayoutBinaryTree202(): Bool =
        Trees.layoutBinaryTree2(
            Trees.fromList("n" :: "k" :: "m" :: "c" :: "a" :: "e" :: "d" :: "g" :: "u" :: "p" :: "q" :: Nil)
        ) == Tree.TNode(Positioned.Positioned("n", 15, 1), Tree.TNode(Positioned.Positioned("k", 7, 2), Tree.TNode(Positioned.Positioned("c", 3, 3), Tree.TNode(Positioned.Positioned("a", 1, 4), Tree.TNil, Tree.TNil), Tree.TNode(Positioned.Positioned("e", 5, 4), Tree.TNode(Positioned.Positioned("d", 4, 5), Tree.TNil, Tree.TNil), Tree.TNode(Positioned.Positioned("g", 6, 5), Tree.TNil, Tree.TNil))), Tree.TNode(Positioned.Positioned("m", 11, 3), Tree.TNil, Tree.TNil)), Tree.TNode(Positioned.Positioned("u", 23, 2), Tree.TNode(Positioned.Positioned("p", 19, 3), Tree.TNil, Tree.TNode(Positioned.Positioned("q", 21, 4), Tree.TNil, Tree.TNil)), Tree.TNil))


//              n
//      k               u
//  c       m       p
//a   e               q
//   d g
}
