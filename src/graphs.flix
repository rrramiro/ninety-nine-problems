

opaque type GEdge[a] = (a, a)

instance Eq[GEdge[a]] with Eq[a] {
    pub def eq(left: GEdge[a], right: GEdge[a]): Bool = match (left, right) {
        case (GEdge(l1, r1), GEdge(l2, r2)) => (l1 == l2 and r1 == r2) or (l1 == r2 and r1 == l2)
    }
}

instance ToString[GEdge[a]] with ToString[a] {
    pub def toString(e: GEdge[a]): String =
        let GEdge(l, r) = e;
        "e#(${l}, ${r})"
}

instance Order[GEdge[a]] with Order[a] {
     pub def compare(e1: GEdge[a], e2: GEdge[a]): Comparison =
        use Order.thenCompare;
        let (GEdge(l1, r1), GEdge(l2, r2)) = (e1, e2);
        (Order.min(l1, r1) <=> Order.min(l2, r2)) `thenCompare` lazy (Order.max(l1, r1) <=> Order.max(l2, r2))

}

enum Graph[a] {
    case Graph(List[a], List[GEdge[a]])
}

instance ToString[Graph[a]] with ToString[a] {
    pub def toString(g: Graph[a]): String =
        let Graph(e, l) = g;
        "Graph#(${e}, ${l})"
}

instance Eq[Graph[a]] with Order[a] {
    pub def eq(left: Graph[a], right: Graph[a]): Bool = match (left, right) {
        case (Graph(e1, l1), Graph(e2, l2)) => (e1 |> List.toSet) == (e2 |> List.toSet) and (l1 |> List.toSet) == (l2 |> List.toSet)
    }
}

opaque type GNode[a] = (a, List[a])

instance Eq[GNode[a]] with Order[a] {
    pub def eq(left: GNode[a], right: GNode[a]): Bool = match (left, right) {
        case (GNode(v1, l1), GNode(v2, l2)) => v1 == v2 and (l1 |> List.toSet) ==  (l2 |> List.toSet)
    }
}

opaque type Adjacency[a] = List[GNode[a]]

instance Eq[Adjacency[a]] with Order[a] {
    pub def eq(left: Adjacency[a], right: Adjacency[a]): Bool = match (left, right) {
        case (Adjacency(g1), Adjacency(g2)) => g1 == g2
    }
}

/*
opaque type GArc[a] = (a, a)
enum DiGraph[a] {
    case DiGraph(List[a], List[GArc[a]])
}
*/

namespace Graphs {
    def graphToAdj(g: Graph[a]): Adjacency[a] with Eq[a] =
        match g {
            case Graph(Nil, _)      => Adjacency(Nil)
            case Graph(x :: xs, ys) =>
                let Adjacency(zs) = graphToAdj(Graph(xs, ys));
                Adjacency(GNode(x, ys |> List.flatMap( w ->
                    let GEdge(u, v) = w;
                    if(u == x) v :: Nil
                    else if (v == x) u :: Nil
                    else Nil
                )) :: zs)
        }

    def adjToGraph(adj: Adjacency[a]): Graph[a] with Eq[a] =
        match adj {
            case Adjacency(Nil) => Graph(Nil, Nil)
            case Adjacency(GNode(v, a):: vs) => 
                let Graph(xs, ys) = adjToGraph(Adjacency(vs));
                Graph(
                    v :: xs,
                    (a |> List.flatMap(x ->
                        if (ys |> List.exists(g -> g == GEdge(x, v))) Nil
                        else GEdge(v, x) :: Nil
                    )) ::: ys
                )
        }

}