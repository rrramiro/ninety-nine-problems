namespace Trees/P67 {

    @test
    def testDisplayTree01(): Bool =
        Trees.display(
            TNode("a", TNode("b", TNode("d", TNil, TNil), TNode("e", TNil, TNil)), TNode("c", TNil, TNode("f", TNode("g", TNil, TNil), TNil)))
        ) == "a(b(d,e),c(,f(g,)))"


    @test 
    def testParseTree01(): Bool =
        Trees.parse("a(b(d,e),c(,f(g,)))") ==
            Some(TNode('a', TNode('b', TNode('d', TNil, TNil), TNode('e', TNil, TNil)), TNode('c', TNil, TNode('f', TNode('g', TNil, TNil), TNil))))

}
