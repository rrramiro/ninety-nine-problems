

pub enum GEdge[a](a, a)

instance Eq[GEdge[a]] with Eq[a] {
    pub def eq(left: GEdge[a], right: GEdge[a]): Bool = match (left, right) {
        case (GEdge.GEdge(l1, r1), GEdge.GEdge(l2, r2)) => (l1 == l2 and r1 == r2) or (l1 == r2 and r1 == l2)
    }
}

instance Hash[GEdge[a]] with Hash[a] {
    pub def hash(x: GEdge[a]): Int32 =
        let GEdge.GEdge(l, r) = x;
        39119 + Hash.hash(l) + Hash.hash(r)
}

instance ToString[GEdge[a]] with ToString[a] {
    pub def toString(e: GEdge[a]): String =
        let GEdge.GEdge(l, r) = e;
        "e#(${l}, ${r})"
}

instance Order[GEdge[a]] with Order[a] {
     pub def compare(e1: GEdge[a], e2: GEdge[a]): Comparison =
        use Order.thenCompare;
        let (GEdge.GEdge(l1, r1), GEdge.GEdge(l2, r2)) = (e1, e2);
        (Order.min(l1, r1) <=> Order.min(l2, r2)) `thenCompare` lazy (Order.max(l1, r1) <=> Order.max(l2, r2))

}

enum Graph[a] {
    case Graph(List[a], List[GEdge[a]])
}

instance ToString[Graph[a]] with ToString[a] {
    pub def toString(g: Graph[a]): String =
        let Graph.Graph(e, l) = g;
        "Graph#(${e}, ${l})"
}

instance Eq[Graph[a]] with Order[a] {
    pub def eq(left: Graph[a], right: Graph[a]): Bool = match (left, right) {
        case (Graph.Graph(e1, l1), Graph.Graph(e2, l2)) => (e1 |> List.toSet) == (e2 |> List.toSet) and (l1 |> List.toSet) == (l2 |> List.toSet)
    }
}

pub enum GNode[a](a, List[a])

instance Eq[GNode[a]] with Order[a] {
    pub def eq(left: GNode[a], right: GNode[a]): Bool = match (left, right) {
        case (GNode.GNode(v1, l1), GNode.GNode(v2, l2)) => v1 == v2 and (l1 |> List.toSet) ==  (l2 |> List.toSet)
    }
}

instance Order[GNode[a]] with Order[a] {
    pub def compare(left: GNode[a], right: GNode[a]): Comparison =
        let (GNode.GNode(v1, _), GNode.GNode(v2, _)) = (left, right);
        v1 <=> v2
}

instance ToString[GNode[a]] with ToString[a] {
    pub def toString(n: GNode[a]): String =
        let GNode.GNode(v, l) = n;
        "n#(${v}, ${l})"
}

pub enum Adjacency[a](List[GNode[a]])

instance Eq[Adjacency[a]] with Order[a] {
    pub def eq(left: Adjacency[a], right: Adjacency[a]): Bool = match (left, right) {
        case (Adjacency.Adjacency(g1), Adjacency.Adjacency(g2)) => (g1 |> List.toSet) == (g2 |> List.toSet)
    }
}

instance ToString[Adjacency[a]] with ToString[a] {
    pub def toString(adj: Adjacency[a]): String =
        let Adjacency.Adjacency(l) = adj;
        "Adjacency#(${l})"
}

pub enum GArc[a](a, a)

instance Eq[GArc[a]] with Eq[a] {
    pub def eq(left: GArc[a], right: GArc[a]): Bool = match (left, right) {
        case (GArc.GArc(l1, r1), GArc.GArc(l2, r2)) => l1 == l2 and r1 == r2
    }
}

instance Hash[GArc[a]] with Hash[a] {
    pub def hash(x: GArc[a]): Int32 =
        let GArc.GArc(l, r) = x;
        3 * 5 * Hash.hash(l) + 7 * Hash.hash(r)
}

instance ToString[GArc[a]] with ToString[a] {
    pub def toString(e: GArc[a]): String =
        let GArc.GArc(l, r) = e;
        "a#(${l}, ${r})"
}

instance Order[GArc[a]] with Order[a] {
     pub def compare(e1: GArc[a], e2: GArc[a]): Comparison =
        use Order.thenCompare;
        let (GArc.GArc(l1, r1), GArc.GArc(l2, r2)) = (e1, e2);
        (l1 <=> l2) `thenCompare` lazy (r1 <=> r2)
}

enum DiGraph[a] {
    case DiGraph(List[a], List[GArc[a]])
}

instance ToString[DiGraph[a]] with ToString[a] {
    pub def toString(g: DiGraph[a]): String =
        let DiGraph.DiGraph(e, l) = g;
        "DiGraph#(${e}, ${l})"
}

instance Eq[DiGraph[a]] with Order[a] {
    pub def eq(left: DiGraph[a], right: DiGraph[a]): Bool = match (left, right) {
        case (DiGraph.DiGraph(e1, l1), DiGraph.DiGraph(e2, l2)) => (e1 |> List.toSet) == (e2 |> List.toSet) and (l1 |> List.toSet) == (l2 |> List.toSet)
    }
}

enum GElem[a] {
    case GVert(a),
    case GLine(a, a)
}

instance Eq[GElem[a]] with Eq[a] {
    pub def eq(left: GElem[a], right: GElem[a]): Bool = match (left, right) {
        case (GElem.GVert(l1), GElem.GVert(l2))         => l1 == l2
        case (GElem.GLine(l1, r1), GElem.GLine(l2, r2)) => l1 == l2 and r1 == r2
        case _                              => false
    }
}

instance Order[GElem[a]] with Order[a] {
     pub def compare(e1: GElem[a], e2: GElem[a]): Comparison =
        use Order.thenCompare;
        match (e1, e2) {
            case (GElem.GVert(l1), GElem.GVert(l2)) => l1 <=> l2
            case (GElem.GLine(l1, r1), GElem.GLine(l2, r2)) => (l1 <=> l2) `thenCompare` lazy (r1 <=> r2)
            case (GElem.GVert(_), GElem.GLine(_,_)) => Comparison.LessThan
            case (GElem.GLine(_,_), GElem.GVert(_)) => Comparison.GreaterThan
        }
}

pub enum Friendly[a](List[GElem[a]])

instance Eq[Friendly[a]] with Order[a] {
    pub def eq(left: Friendly[a], right: Friendly[a]): Bool = match (left, right) {
        case (Friendly.Friendly(l1), Friendly.Friendly(l2)) => (l1 |> List.toSet) ==  (l2 |> List.toSet)
    }
}

mod Graphs {
    def graphToAdj(g: Graph[a]): Adjacency[a] with Eq[a] =
        match g {
            case Graph.Graph(Nil, _)      => Adjacency.Adjacency(Nil)
            case Graph.Graph(x :: xs, ys) =>
                let Adjacency.Adjacency(zs) = graphToAdj(Graph.Graph(xs, ys));
                Adjacency.Adjacency(GNode.GNode(x, ys |> List.flatMap( w ->
                    match w {
                        case GEdge.GEdge(u, v) if u == x => v :: Nil
                        case GEdge.GEdge(u, v) if v == x => u :: Nil
                        case _                     => Nil
                    }
                )) :: zs)
        }

    def adjToGraph(adj: Adjacency[a]): Graph[a] with Eq[a] =
        match adj {
            case Adjacency.Adjacency(Nil) => Graph.Graph(Nil, Nil)
            case Adjacency.Adjacency(GNode.GNode(v, a):: vs) =>
                let Graph.Graph(xs, ys) = adjToGraph(Adjacency.Adjacency(vs));
                Graph.Graph(
                    v :: xs,
                    (a |> List.flatMap(x ->
                        if (ys |> List.exists(g -> g == GEdge.GEdge(v, x))) Nil
                        else GEdge.GEdge(v, x) :: Nil
                    )) ::: ys
                )
        }

    def digraphToAdj(dig: DiGraph[a]): Adjacency[a] with Eq[a] =
        match dig {
            case DiGraph.DiGraph(Nil, _)      => Adjacency.Adjacency(Nil)
            case DiGraph.DiGraph(x :: xs, ys) =>
                let Adjacency.Adjacency(zs) = digraphToAdj(DiGraph.DiGraph(xs, ys));
                Adjacency.Adjacency(GNode.GNode(x, ys |> List.flatMap(w ->
                    match w {
                        case GArc.GArc(u, v) if u == x => v :: Nil
                        case _                    => Nil
                    }
                )) :: zs)
        }

    def adjToDigraph(adj: Adjacency[a]): DiGraph[a] with Eq[a] =
        match adj {
            case Adjacency.Adjacency(Nil) => DiGraph.DiGraph(Nil, Nil)
            case Adjacency.Adjacency(GNode.GNode(v, a):: vs) =>
                let DiGraph.DiGraph(xs, ys) = adjToDigraph(Adjacency.Adjacency(vs));
                DiGraph.DiGraph(
                    v :: xs,
                    (a |> List.flatMap(x ->
                        if (ys |> List.exists(g -> g == GArc.GArc(v, x))) Nil
                        else GArc.GArc(v, x) :: Nil
                    )) ::: ys
                )
        }

    def digraphToFri(dig: DiGraph[a]): Friendly[a] with Eq[a] =
         match dig {
            case DiGraph.DiGraph(Nil, _) => Friendly.Friendly(Nil)
            case DiGraph.DiGraph(xs, ys) =>
                /*
                ys |> List.foldLeft((acc, y) ->
                    let (a, n) = acc;
                    let GArc(u, v) = y;
                    (a.filter(s -> s != u || s != v), GLine(u,v) :: n)
                , (xs, Nil))
                */
                let linked = ys |> List.flatMap( w ->
                        let GArc.GArc(u, v) = w;
                        u :: v :: Nil
                        ) |> List.distinct;

                Friendly.Friendly(
                    (
                        ys |> List.map(w ->
                            let GArc.GArc(u, v) = w;
                            GElem.GLine(u,v)
                        )
                    ) ::: (
                        xs |> List.filter(x ->
                            not (linked |> List.exists(y -> y == x))
                        ) |> List.map(y -> GElem.GVert(y))
                    )
                )
        }
}
