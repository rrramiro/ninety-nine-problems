// Layout a binary tree
namespace Trees/P66 {

    @test
    def testLayoutBinaryTree301(): Bool & Impure =
        let result = Trees.layoutBinaryTree3(
            TNode("a", TNode("b", TNil, TNode("c", TNil, TNil)), TNode("d", TNil, TNil))
        );
        println(result);
        result == TNode(Positioned("a", 2, 1), TNode(Positioned("b", 1, 2), TNil, TNode(Positioned("c", 2, 3), TNil, TNil)), TNode(Positioned("d", 3, 2), TNil, TNil))

// a
//b d
// c

    @test
    def testLayoutBinaryTree302(): Bool & Impure =
        let result = Trees.layoutBinaryTree3(
            Trees.fromList("n" :: "k" :: "m" :: "c" :: "a" :: "e" :: "d" :: "g" :: "u" :: "p" :: "q" :: Nil)
        );
        println(result);
        result == TNode(Positioned("n", 5, 1), TNode(Positioned("k", 3, 2), TNode(Positioned("c", 2, 3), TNode(Positioned("a", 1, 4), TNil, TNil), TNode(Positioned("e", 3, 4), TNode(Positioned("d", 2, 5), TNil, TNil), TNode(Positioned("g", 4, 5), TNil, TNil))), TNode(Positioned("m", 4, 3), TNil, TNil)), TNode(Positioned("u", 7, 2), TNode(Positioned("p", 6, 3), TNil, TNode(Positioned("q", 7, 4), TNil, TNil)), TNil))

//    n
//  k   u
// c m p
//a e   q
// d g
}
