// Construct height-balanced binary trees
mod Trees.P59 {
    @test
    def testhBalanced01(): Bool =
        Trees.heightBalanced(2, "c") == (
            Tree.TNode("c", Tree.TNode("c", Tree.TNil, Tree.TNil), Tree.TNode("c", Tree.TNil, Tree.TNil)) ::
            Tree.TNode("c", Tree.TNode("c", Tree.TNil, Tree.TNil), Tree.TNil) ::
            Tree.TNode("c", Tree.TNil, Tree.TNode("c", Tree.TNil, Tree.TNil)) :: Nil
        )

    @test
    def testhBalanced02(): Bool =
        (Trees.heightBalanced(3, "c") |> List.length) == 15

    @test
    def testhBalanced03(): Bool =
        Trees.heightBalanced(3, "c") |> List.forAll(Trees.isHeightBalanced)

}
