

pub enum GEdge[a](a, a)

instance Eq[GEdge[a]] with Eq[a] {
    pub def eq(left: GEdge[a], right: GEdge[a]): Bool = match (left, right) {
        case (GEdge(l1, r1), GEdge(l2, r2)) => (l1 == l2 and r1 == r2) or (l1 == r2 and r1 == l2)
    }
}

instance Hash[GEdge[a]] with Hash[a] {
    pub def hash(x: GEdge[a]): Int32 =
        let GEdge(l, r) = x;
        39119 + Hash.hash(l) + Hash.hash(r)
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

pub enum GNode[a](a, List[a])

instance Eq[GNode[a]] with Order[a] {
    pub def eq(left: GNode[a], right: GNode[a]): Bool = match (left, right) {
        case (GNode(v1, l1), GNode(v2, l2)) => v1 == v2 and (l1 |> List.toSet) ==  (l2 |> List.toSet)
    }
}

instance Order[GNode[a]] with Order[a] {
    pub def compare(left: GNode[a], right: GNode[a]): Comparison =
        let (GNode(v1, _), GNode(v2, _)) = (left, right);
        v1 <=> v2
}

instance ToString[GNode[a]] with ToString[a] {
    pub def toString(n: GNode[a]): String =
        let GNode(v, l) = n;
        "n#(${v}, ${l})"
}

pub enum Adjacency[a](List[GNode[a]])

instance Eq[Adjacency[a]] with Order[a] {
    pub def eq(left: Adjacency[a], right: Adjacency[a]): Bool = match (left, right) {
        case (Adjacency(g1), Adjacency(g2)) => (g1 |> List.toSet) == (g2 |> List.toSet)
    }
}

instance ToString[Adjacency[a]] with ToString[a] {
    pub def toString(adj: Adjacency[a]): String =
        let Adjacency(l) = adj;
        "Adjacency#(${l})"
}

pub enum GArc[a](a, a)

instance Eq[GArc[a]] with Eq[a] {
    pub def eq(left: GArc[a], right: GArc[a]): Bool = match (left, right) {
        case (GArc(l1, r1), GArc(l2, r2)) => l1 == l2 and r1 == r2
    }
}

instance Hash[GArc[a]] with Hash[a] {
    pub def hash(x: GArc[a]): Int32 =
        let GArc(l, r) = x;
        3 * 5 * Hash.hash(l) + 7 * Hash.hash(r)
}

instance ToString[GArc[a]] with ToString[a] {
    pub def toString(e: GArc[a]): String =
        let GArc(l, r) = e;
        "a#(${l}, ${r})"
}

instance Order[GArc[a]] with Order[a] {
     pub def compare(e1: GArc[a], e2: GArc[a]): Comparison =
        use Order.thenCompare;
        let (GArc(l1, r1), GArc(l2, r2)) = (e1, e2);
        (l1 <=> l2) `thenCompare` lazy (r1 <=> r2)
}

enum DiGraph[a] {
    case DiGraph(List[a], List[GArc[a]])
}

instance ToString[DiGraph[a]] with ToString[a] {
    pub def toString(g: DiGraph[a]): String =
        let DiGraph(e, l) = g;
        "DiGraph#(${e}, ${l})"
}

instance Eq[DiGraph[a]] with Order[a] {
    pub def eq(left: DiGraph[a], right: DiGraph[a]): Bool = match (left, right) {
        case (DiGraph(e1, l1), DiGraph(e2, l2)) => (e1 |> List.toSet) == (e2 |> List.toSet) and (l1 |> List.toSet) == (l2 |> List.toSet)
    }
}

enum GElem[a] {
    case GVert(a),
    case GLine(a, a)
}

instance Eq[GElem[a]] with Eq[a] {
    pub def eq(left: GElem[a], right: GElem[a]): Bool = match (left, right) {
        case (GVert(l1), GVert(l2))         => l1 == l2
        case (GLine(l1, r1), GLine(l2, r2)) => l1 == l2 and r1 == r2
        case _                              => false
    }
}

instance Order[GElem[a]] with Order[a] {
     pub def compare(e1: GElem[a], e2: GElem[a]): Comparison =
        use Order.thenCompare;
        match (e1, e2) {
            case (GVert(l1), GVert(l2)) => l1 <=> l2
            case (GLine(l1, r1), GLine(l2, r2)) => (l1 <=> l2) `thenCompare` lazy (r1 <=> r2)
            case (GVert(_), GLine(_,_)) => LessThan
            case (GLine(_,_), GVert(_)) => GreaterThan
        }
}

pub enum Friendly[a](List[GElem[a]])

instance Eq[Friendly[a]] with Order[a] {
    pub def eq(left: Friendly[a], right: Friendly[a]): Bool = match (left, right) {
        case (Friendly(l1), Friendly(l2)) => (l1 |> List.toSet) ==  (l2 |> List.toSet)
    }
}

namespace Graphs {
    def graphToAdj(g: Graph[a]): Adjacency[a] with Eq[a] =
        match g {
            case Graph(Nil, _)      => Adjacency(Nil)
            case Graph(x :: xs, ys) =>
                let Adjacency(zs) = graphToAdj(Graph(xs, ys));
                Adjacency(GNode(x, ys |> List.flatMap( w ->
                    match w {
                        case GEdge(u, v) if u == x => v :: Nil
                        case GEdge(u, v) if v == x => u :: Nil
                        case _                     => Nil
                    }
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
                        if (ys |> List.exists(g -> g == GEdge(v, x))) Nil
                        else GEdge(v, x) :: Nil
                    )) ::: ys
                )
        }

    def digraphToAdj(dig: DiGraph[a]): Adjacency[a] with Eq[a] =
        match dig {
            case DiGraph(Nil, _)      => Adjacency(Nil)
            case DiGraph(x :: xs, ys) =>
                let Adjacency(zs) = digraphToAdj(DiGraph(xs, ys));
                Adjacency(GNode(x, ys |> List.flatMap(w ->
                    match w {
                        case GArc(u, v) if u == x => v :: Nil
                        case _                    => Nil
                    }
                )) :: zs)
        }

    def adjToDigraph(adj: Adjacency[a]): DiGraph[a] with Eq[a] =
        match adj {
            case Adjacency(Nil) => DiGraph(Nil, Nil)
            case Adjacency(GNode(v, a):: vs) =>
                let DiGraph(xs, ys) = adjToDigraph(Adjacency(vs));
                DiGraph(
                    v :: xs,
                    (a |> List.flatMap(x ->
                        if (ys |> List.exists(g -> g == GArc(v, x))) Nil
                        else GArc(v, x) :: Nil
                    )) ::: ys
                )
        }

    def digraphToFri(dig: DiGraph[a]): Friendly[a] with Eq[a] =
         match dig {
            case DiGraph(Nil, _) => Friendly(Nil)
            case DiGraph(xs, ys) =>
                /*
                ys |> List.foldLeft((acc, y) ->
                    let (a, n) = acc;
                    let GArc(u, v) = y;
                    (a.filter(s -> s != u || s != v), GLine(u,v) :: n)
                , (xs, Nil))
                */
                let linked = ys |> List.flatMap( w ->
                        let GArc(u, v) = w;
                        u :: v :: Nil
                        ) |> List.distinct;

                Friendly(
                    (
                        ys |> List.map(w ->
                            let GArc(u, v) = w;
                            GLine(u,v)
                        )
                    ) ::: (
                        xs |> List.filter(x ->
                            not (linked |> List.exists(y -> y == x))
                        ) |> List.map(y -> GVert(y))
                    )
                )
        }
}
