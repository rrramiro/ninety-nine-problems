// Layout a binary tree
mod Trees.P64 {

    @test
    def testLayoutBinaryTree01(): Bool =
        Trees.layoutBinaryTree(Tree.TNode("a", Tree.TNode("b", Tree.TNil, Tree.TNode("c", Tree.TNil, Tree.TNil)), Tree.TNode("d", Tree.TNil, Tree.TNil))) ==
            Tree.TNode(Positioned.Positioned("a", 3, 1), Tree.TNode(Positioned.Positioned("b", 1, 2), Tree.TNil, Tree.TNode(Positioned.Positioned("c", 2, 3), Tree.TNil, Tree.TNil)), Tree.TNode(Positioned.Positioned("d", 4, 2), Tree.TNil, Tree.TNil))
//  a
//b  d
// c
    @test
    def testLayoutBinaryTree02(): Bool =
        Trees.layoutBinaryTree(
            Trees.fromList("n" :: "k" :: "m" :: "c" :: "a" :: "h" :: "g" :: "e" :: "u" :: "p" :: "s" :: "q" :: Nil)
        ) == Tree.TNode(Positioned.Positioned("n", 8, 1), Tree.TNode(Positioned.Positioned("k", 6, 2), Tree.TNode(Positioned.Positioned("c", 2, 3), Tree.TNode(Positioned.Positioned("a", 1, 4), Tree.TNil, Tree.TNil), Tree.TNode(Positioned.Positioned("h", 5, 4), Tree.TNode(Positioned.Positioned("g", 4, 5), Tree.TNode(Positioned.Positioned("e", 3, 6), Tree.TNil, Tree.TNil), Tree.TNil), Tree.TNil)), Tree.TNode(Positioned.Positioned("m", 7, 3), Tree.TNil, Tree.TNil)), Tree.TNode(Positioned.Positioned("u", 12, 2), Tree.TNode(Positioned.Positioned("p", 9, 3), Tree.TNil, Tree.TNode(Positioned.Positioned("s", 11, 4), Tree.TNode(Positioned.Positioned("q", 10, 5), Tree.TNil, Tree.TNil), Tree.TNil)), Tree.TNil))

//       n
//     k     u
//  c   m p
//a   h     s
//   g     q
//  e
}
