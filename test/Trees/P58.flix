// Generate-and-test paradigm
mod Trees.P58 {

    def symcBalanced(n: Int32, value: a): List[Tree[a]] =
        Trees.cBalanced(n, value) |> List.filter(Trees.isSymmetric)

    @test
    def testsymcBalanced01(): Bool =
        symcBalanced(5, "x") == (
            Tree.TNode("x", Tree.TNode("x", Tree.TNil, Tree.TNode("x", Tree.TNil, Tree.TNil)), Tree.TNode("x", Tree.TNode("x", Tree.TNil, Tree.TNil), Tree.TNil)) ::
            Tree.TNode("x", Tree.TNode("x", Tree.TNode("x", Tree.TNil, Tree.TNil), Tree.TNil), Tree.TNode("x", Tree.TNil, Tree.TNode("x", Tree.TNil, Tree.TNil))) :: Nil
        )
}
