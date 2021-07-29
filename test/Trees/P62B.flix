// Collect the nodes at a given level in a list
namespace Trees/P62B {

    @test
    def testatlevel01(): Bool =
        Trees.atlevel(0, TNode("a", TNode("b", TNil, TNil), TNode("c", TNode("d", TNil, TNil), TNode("e", TNil, TNil)))) == "a" :: Nil

    @test
    def testatlevel02(): Bool =
        Trees.atlevel(1, TNode("a", TNode("b", TNil, TNil), TNode("c", TNode("d", TNil, TNil), TNode("e", TNil, TNil)))) == "b" :: "c" :: Nil

    @test
    def testatlevel03(): Bool =
        Trees.atlevel(2, TNode("a", TNode("b", TNil, TNil), TNode("c", TNode("d", TNil, TNil), TNode("e", TNil, TNil)))) == "d" :: "e" :: Nil

}
