mod P50 {
    enum Component[a] {
        case Composite(Int32)
        case Leaf(a, Int32)
    }

    def toCode(t: Tree[Component[a]], prefix: String): List[(a, String)] = match t {
        case Tree.TNode(Component.Leaf(element, _), _, _) => (element, prefix) :: Nil
        case Tree.TNode(_, left, right)            => toCode(left, "${prefix}0") ::: toCode(right, "${prefix}1")
        case Tree.TNil                             => Nil
    }

    def freq(t: Tree[Component[a]]): Int32 = match t {
        case Tree.TNode(Component.Composite(f), _, _)     => f
        case Tree.TNode(Component.Leaf(_, f), _, _) => f
        case Tree.TNil                       => 0
    }


    def dequeueSmallest(q1: Queue[Tree[Component[a]]], q2: Queue[Tree[Component[a]]]): (Option[Tree[Component[a]]], Queue[Tree[Component[a]]], Queue[Tree[Component[a]]]) =
        if (Queues.isEmpty(q2))
            let (x, xs) = Queues.dequeue(q1);
            (x, xs, q2)
        else if (Queues.isEmpty(q1) or (Option.zip(Queues.front(q2), Queues.front(q1)) |> Option.map(y ->
            let (f2, f1) = y;
            freq(f2) < freq(f1)
        ) |> Option.forAll(x -> x)))
            let (x, xs) = Queues.dequeue(q2);
            (x, q1, xs)
        else
            let (x, xs) = Queues.dequeue(q1);
            (x, xs, q2)

    pub def huffmanR(q1: Queue[Tree[Component[a]]], q2: Queue[Tree[Component[a]]]): List[(a, String)] =
        use List.flatMap;
        if ((Queues.length(q1) + Queues.length(q2)) == 1)
            forM(fr <- (if (Queues.isEmpty(q1)) Queues.front(q2) else Queues.front(q1)) |> Option.toList; r <- toCode(fr, ""))
                yield r
        else
            let (ov1, q3, q4) = dequeueSmallest(q1, q2);
            let (ov2, q5, q6) = dequeueSmallest(q3, q4);
            forM(v1 <- Option.toList(ov1); v2 <- Option.toList(ov2); r <- huffmanR(q5, Queues.enqueue(Tree.TNode(Component.Composite(freq(v1) + freq(v2)),v1, v2), q6)))
                yield r

    pub def huffman(ls: List[(a, Int32)]): List[(a, String)] =
        let init = ls |> List.sortWith((a, b) ->
                let (_, freqA) = a;
                let (_, freqB) = b;
                Comparison.fromInt32(freqA - freqB)
            ) |> List.map(x ->
                let (e, f) = x;
                Tree.TNode(Component.Leaf(e, f), Tree.TNil, Tree.TNil)
            );
        huffmanR(Queues.enqueueAll(init, Queues.empty()), Queues.empty())

    @test
    def testhuffman01(): Bool =
        huffman(("a", 45) :: ("b", 13) :: ("c", 12) :: ("d", 16) :: ("e", 9) :: ("f", 5) :: Nil) ==
        ("a", "0") :: ("c", "100") :: ("b", "101") :: ("f", "1100") :: ("e", "1101") :: ("d", "111") :: Nil

}
