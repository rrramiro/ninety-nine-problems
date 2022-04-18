// Construct height-balanced binary trees with a given number of nodes
namespace Trees/P60 {

    def minHbalNodes(height: Int32): Int32 = match height {
        case n if n < 1 => 0
        case 1          => 1
        case n          => minHbalNodes(n - 1) + minHbalNodes(n - 2) + 1
    }

    def minHbalHeight(nodes: Int32): Int32 =
        if (nodes == 0) 0 else minHbalHeight(nodes / 2) + 1

    def maxHbalHeight(nodes: Int32): Option[Int32] =
        DelayLists.from(1) |>
        DelayLists.takeWhile(x -> minHbalNodes(x) <= nodes) |>
        DelayLists.last

    pub def heightBalancedWithNodes(nodes: Int32, value: a): List[Tree[a]] =
        use List.flatMap;
        let minhbh = minHbalHeight(nodes);
        let* maxhbh = maxHbalHeight(nodes) |> Option.toList;
        let* n = List.range(minhbh, maxhbh + 1);
        Trees.heightBalanced(n, value) |> List.filter(x -> Trees.nodeCount(x) == nodes)

    @test
    def testheightBalancedWithNodes01(): Bool =
        heightBalancedWithNodes(4, "d") == (
            TNode("d", TNode("d", TNode("d", TNil, TNil), TNil), TNode("d", TNil, TNil)) ::
            TNode("d", TNode("d", TNil, TNil), TNode("d", TNode("d", TNil, TNil), TNil)) ::
            TNode("d", TNode("d", TNil, TNode("d", TNil, TNil)), TNode("d", TNil, TNil)) ::
            TNode("d", TNode("d", TNil, TNil), TNode("d", TNil, TNode("d", TNil, TNil))) :: Nil
        )

    @test
    def testheightBalancedWithNodes02(): Bool =
        (heightBalancedWithNodes(4, "d") |> List.length) == 4

}
