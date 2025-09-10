//Cycle from a given node.
mod Graphs.P82 {
    use Graph.Graph;
    use GEdge.GEdge;

    def cycle(g: Graph[a], src: a): List[List[a]] with Order[a] = {
        def concatIfNotMemberInTheLastPosition(x: a, xs: List[a]) =
            if (List.memberOf(x, xs |> List.init |> Option.getWithDefault(Nil))) Vector.empty() else Vector#{x :: xs};

        let Graph.Graph(_, l) = g;
        let db = inject l |> List.map(e -> let GEdge(f, t) = e; (f, t)) into Edge/2;
        let pr = #{
            Path(x, y, path) :- Edge(x, y), let path = concatIfNotMemberInTheLastPosition(x, y :: Nil).
            Path(x, z, path) :- Path(y, z, ppath), Edge(x, y), let path = concatIfNotMemberInTheLastPosition(x, ppath).
            Cycle(path) :- Path(src, src, path).
        };
        query db, pr select path from Cycle(path) |> Vector.toList
    }

    @test
    pub def testCycle01(): Bool = {
        cycle(Graph(
            1 :: 2 :: 3 :: 4 :: 5 :: 6 :: Nil,
            GEdge(1,2) :: GEdge(2,3) :: GEdge(1,3) :: GEdge(3,4) :: GEdge(4,2) :: GEdge(5,6) :: Nil
        ), 2) == ((2 :: 3 :: 4 :: 2 :: Nil) :: Nil)
    }

    @test
    pub def testCycle02(): Bool = {
        cycle(Graph(
            1 :: 2 :: 3 :: 4 :: 5 :: 6 :: Nil,
            GEdge(1,2) :: GEdge(2,3) :: GEdge(1,3) :: GEdge(3,4) :: GEdge(4,2) :: GEdge(5,6) :: Nil
        ), 1) == Nil
    }
}
