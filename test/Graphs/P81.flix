//Path from one node to another one
mod Graphs.P81 {
    use Graph.Graph;
    use GEdge.GEdge;

    def concatIfNotMember(x: a, xs: List[a]): Vector[List[a]] with Eq[a] =
        if (List.memberOf(x, xs)) Vector.empty() else Vector#{x :: xs }

    def paths(g: Graph[a], src: a, dst: a): List[List[a]] with Order[a] = {
        let Graph.Graph(_, l) = g;
        let toInject = l |> List.map(e -> let GEdge(f, t) = e; (f, t));
        let db = inject toInject into Edge/2;
        let pr = #{
            Path(x, y, path) :- Edge(x, y), let path = concatIfNotMember(x, y :: Nil).
            Path(x, z, path) :- Path(y, z, ppath), Edge(x, y), let path = concatIfNotMember(x, ppath).
        };
        query db, pr select path from Path(src, dst, path) |> Vector.toList
    }

    @test
    pub def testPath01(): Bool = {
        let x = paths(Graph(
            1 :: 2 :: 3 :: 4 :: 5 :: 6 :: Nil,
            GEdge(1,2) :: GEdge(2,3) :: GEdge(1,3) :: GEdge(3,4) :: GEdge(4,2) :: GEdge(5,6) :: Nil
        ), 1, 4);
        x == ((1 :: 2 :: 3 :: 4 :: Nil) :: (1 :: 3 :: 4 :: Nil) :: Nil)
    }

    @test
    pub def testPath02(): Bool = {
        paths(Graph(
            1 :: 2 :: 3 :: 4 :: 5 :: 6 :: Nil,
            GEdge(1,2) :: GEdge(2,3) :: GEdge(1,3) :: GEdge(3,4) :: GEdge(4,2) :: GEdge(5,6) :: Nil
        ), 2, 6) == Nil
    }
}