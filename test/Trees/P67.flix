mod Trees.P67 {

    @test
    def testDisplayTree01(): Bool =
        Trees.display(
            Tree.TNode("a", Tree.TNode("b", Tree.TNode("d", Tree.TNil, Tree.TNil), Tree.TNode("e", Tree.TNil, Tree.TNil)), Tree.TNode("c", Tree.TNil, Tree.TNode("f", Tree.TNode("g", Tree.TNil, Tree.TNil), Tree.TNil)))
        ) == "a(b(d,e),c(,f(g,)))"


    @test
    def testParseTree01(): Bool =
        Trees.parse("a(b(d,e),c(,f(g,)))") ==
            Some(Tree.TNode('a', Tree.TNode('b', Tree.TNode('d', Tree.TNil, Tree.TNil), Tree.TNode('e', Tree.TNil, Tree.TNil)), Tree.TNode('c', Tree.TNil, Tree.TNode('f', Tree.TNode('g', Tree.TNil, Tree.TNil), Tree.TNil))))

}
