// Layout a binary tree
mod Trees.P66 {

    @test
    def testLayoutBinaryTree301(): Bool =
        Trees.layoutBinaryTree3(
            Tree.TNode("a", Tree.TNode("b", Tree.TNil, Tree.TNode("c", Tree.TNil, Tree.TNil)), Tree.TNode("d", Tree.TNil, Tree.TNil))
        ) == Tree.TNode(Positioned.Positioned("a", 2, 1), Tree.TNode(Positioned.Positioned("b", 1, 2), Tree.TNil, Tree.TNode(Positioned.Positioned("c", 2, 3), Tree.TNil, Tree.TNil)), Tree.TNode(Positioned.Positioned("d", 3, 2), Tree.TNil, Tree.TNil))

// a
//b d
// c

    @test
    def testLayoutBinaryTree302(): Bool =
        Trees.layoutBinaryTree3(
            Trees.fromList("n" :: "k" :: "m" :: "c" :: "a" :: "e" :: "d" :: "g" :: "u" :: "p" :: "q" :: Nil)
        ) == Tree.TNode(Positioned.Positioned("n", 5, 1), Tree.TNode(Positioned.Positioned("k", 3, 2), Tree.TNode(Positioned.Positioned("c", 2, 3), Tree.TNode(Positioned.Positioned("a", 1, 4), Tree.TNil, Tree.TNil), Tree.TNode(Positioned.Positioned("e", 3, 4), Tree.TNode(Positioned.Positioned("d", 2, 5), Tree.TNil, Tree.TNil), Tree.TNode(Positioned.Positioned("g", 4, 5), Tree.TNil, Tree.TNil))), Tree.TNode(Positioned.Positioned("m", 4, 3), Tree.TNil, Tree.TNil)), Tree.TNode(Positioned.Positioned("u", 7, 2), Tree.TNode(Positioned.Positioned("p", 6, 3), Tree.TNil, Tree.TNode(Positioned.Positioned("q", 7, 4), Tree.TNil, Tree.TNil)), Tree.TNil))

//    n
//  k   u
// c m p
//a e   q
// d g
}
