namespace Trees/P56 {

    @test
    def testIsSymmetric00(): Bool =
        Trees.isSymmetric(TNode('a', TNil, TNil))

    @test
    def testIsSymmetric01(): Bool =
        Trees.isSymmetric(TNode('a', TNode('b', TNil, TNil), TNode('c', TNil, TNil)))

    @test
    def testIsSymmetric02(): Bool =
        not Trees.isSymmetric(TNode('a', TNil, TNode('c', TNil, TNil)))

    @test
    def testIsSymmetric03(): Bool =
        not Trees.isSymmetric(TNode('a', TNode('b', TNil, TNil), TNil))

    def rgt(): Tree[String] = TNode("a", TNil, TNode("b", TNil, TNode("c", TNil, TNil)))
    def lft(): Tree[String] = TNode("a", TNode("b", TNode("c", TNil, TNil), TNil), TNil)

    @test
    def testIsSymmetric04(): Bool =
        Trees.isSymmetric(TNode("x", lft(), rgt()))

    @test
    def testIsSymmetric05(): Bool =
        Trees.isSymmetric(TNode("x", rgt(), lft()))

    @test
    def testIsSymmetric06(): Bool =
        not Trees.isSymmetric(TNode("x", rgt(), rgt()))

    @test
    def testIsSymmetric07(): Bool =
        not Trees.isSymmetric(TNode("x", lft(), lft()))

}
