mod Trees.P56 {

    @test
    def testIsSymmetric00(): Bool =
        Trees.isSymmetric(Tree.TNode('a', Tree.TNil, Tree.TNil))

    @test
    def testIsSymmetric01(): Bool =
        Trees.isSymmetric(Tree.TNode('a', Tree.TNode('b', Tree.TNil, Tree.TNil), Tree.TNode('c', Tree.TNil, Tree.TNil)))

    @test
    def testIsSymmetric02(): Bool =
        not Trees.isSymmetric(Tree.TNode('a', Tree.TNil, Tree.TNode('c', Tree.TNil, Tree.TNil)))

    @test
    def testIsSymmetric03(): Bool =
        not Trees.isSymmetric(Tree.TNode('a', Tree.TNode('b', Tree.TNil, Tree.TNil), Tree.TNil))

    def rgt(): Tree[String] = Tree.TNode("a", Tree.TNil, Tree.TNode("b", Tree.TNil, Tree.TNode("c", Tree.TNil, Tree.TNil)))
    def lft(): Tree[String] = Tree.TNode("a", Tree.TNode("b", Tree.TNode("c", Tree.TNil, Tree.TNil), Tree.TNil), Tree.TNil)

    @test
    def testIsSymmetric04(): Bool =
        Trees.isSymmetric(Tree.TNode("x", lft(), rgt()))

    @test
    def testIsSymmetric05(): Bool =
        Trees.isSymmetric(Tree.TNode("x", rgt(), lft()))

    @test
    def testIsSymmetric06(): Bool =
        not Trees.isSymmetric(Tree.TNode("x", rgt(), rgt()))

    @test
    def testIsSymmetric07(): Bool =
        not Trees.isSymmetric(Tree.TNode("x", lft(), lft()))

}
