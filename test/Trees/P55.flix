//Construct completely balanced binary trees
namespace Trees/P55 {

    @test
    def testcBalanced01(): Bool =
        Trees.cBalanced(2, "x") == TNode("x", TNil, TNode("x", TNil, TNil)) :: TNode("x", TNode("x", TNil, TNil), TNil) :: Nil

    @test
    def testcBalanced02(): Bool =
        Trees.cBalanced(3, "x") == TNode("x", TNode("x", TNil, TNil), TNode("x", TNil, TNil)) :: Nil

    @test
    def testcBalanced03(): Bool =
        Trees.cBalanced(4, "x") == (
            TNode("x",
                TNode("x", TNil, TNil),
                TNode("x", TNil,
                    TNode("x", TNil,TNil)
                )
            ) ::
            TNode("x",
                TNode("x", TNil,
                    TNode("x", TNil, TNil)
                ),
                TNode("x", TNil, TNil)
            ) ::
            TNode("x",
                TNode("x", TNil, TNil),
                TNode("x",
                    TNode("x", TNil, TNil),
                    TNil
                )
            ) ::
            TNode("x",
                TNode("x",
                    TNode("x", TNil, TNil),
                    TNil
                ),
                TNode("x", TNil, TNil)
            ) :: Nil
        )

    @test
    def testcBalanced04(): Bool & Impure =
        let actual = Trees.cBalanced(40, "x");
        println(List.length(actual));
        List.length(actual) == 524288

}
