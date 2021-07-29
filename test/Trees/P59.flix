// Construct height-balanced binary trees
namespace Trees/P59 {
    @test
    def testhBalanced01(): Bool =
        Trees.heightBalanced(2, "c") == (
            TNode("c", TNode("c", TNil, TNil), TNode("c", TNil, TNil)) ::
            TNode("c", TNode("c", TNil, TNil), TNil) ::
            TNode("c", TNil, TNode("c", TNil, TNil)) :: Nil
        )

    @test
    def testhBalanced02(): Bool =
        (Trees.heightBalanced(3, "c") |> List.length) == 15

    @test
    def testhBalanced03(): Bool =
        Trees.heightBalanced(3, "c") |> List.forall(Trees.isHeightBalanced)

}
