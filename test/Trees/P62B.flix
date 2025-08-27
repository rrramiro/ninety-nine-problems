// Collect the nodes at a given level in a list
mod Trees.P62B {

    @test
    def testatlevel01(): Bool =
        Trees.atlevel(0, Tree.TNode("a", Tree.TNode("b", Tree.TNil, Tree.TNil), Tree.TNode("c", Tree.TNode("d", Tree.TNil, Tree.TNil), Tree.TNode("e", Tree.TNil, Tree.TNil)))) == "a" :: Nil

    @test
    def testatlevel02(): Bool =
        Trees.atlevel(1, Tree.TNode("a", Tree.TNode("b", Tree.TNil, Tree.TNil), Tree.TNode("c", Tree.TNode("d", Tree.TNil, Tree.TNil), Tree.TNode("e", Tree.TNil, Tree.TNil)))) == "b" :: "c" :: Nil

    @test
    def testatlevel03(): Bool =
        Trees.atlevel(2, Tree.TNode("a", Tree.TNode("b", Tree.TNil, Tree.TNil), Tree.TNode("c", Tree.TNode("d", Tree.TNil, Tree.TNil), Tree.TNode("e", Tree.TNil, Tree.TNil)))) == "d" :: "e" :: Nil

}
