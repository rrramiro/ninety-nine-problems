// Generate-and-test paradigm
namespace Trees/P58 {

    def symcBalanced(n: Int32, value: a): List[Tree[a]] =
        Trees.cBalanced(n, value) |> List.filter(Trees.isSymmetric)

    @test
    def testsymcBalanced01(): Bool =
        symcBalanced(5, "x") == (
            TNode("x", TNode("x", TNil, TNode("x", TNil, TNil)), TNode("x", TNode("x", TNil, TNil), TNil)) ::
            TNode("x", TNode("x", TNode("x", TNil, TNil), TNil), TNode("x", TNil, TNode("x", TNil, TNil))) :: Nil
        )
}
