//Construct all spanning trees
mod Graphs.P83 {
    use Graph.Graph;
    use GEdge.GEdge;

    def allSpanningTrees(g: Graph[a]): List[List[a]] with Order[a] = {
        let Graph(nodes, edges) = g;
        def concatIfNotMember(x: a, xs: List[a]): Vector[(List[a], Bool)] =
            if (List.memberOf(x, xs)) Vector.empty() else {
                let l = x :: xs;
                let hasAllNodes =  nodes |> List.forAll(e -> List.memberOf(e, l));
                Vector#{ (l, hasAllNodes)}
            };

        let edgeList = edges |> List.map(e -> let GEdge(f, t) = e; (f, t));
        let db = inject edgeList into Edge/2;
        let pr = #{
            Connected(x, y, path, hasAll) :- Edge(x, y), let (path, hasAll) = concatIfNotMember(x, y :: Nil).
            Connected(x, z, path, hasAll) :- Connected(y, z, ppath, _), Edge(x, y), let (path, hasAll) = concatIfNotMember(x, ppath).
            Connected(x, z, path, hasAll) :- Connected(y, z, ppath, _), Edge(y, x), let (path, hasAll) = concatIfNotMember(x, ppath).
        };
        query db, pr select path from Connected(_, _, path, true) |> Vector.toList
    }

    @test
    pub def testAllSpanningTrees01(): Bool = {
        allSpanningTrees(Graph(
            'a' :: 'b' :: 'c' :: 'd' :: 'e' :: 'f' :: 'g' :: 'h' :: Nil,
            GEdge('a', 'b') :: GEdge('a', 'd') :: GEdge('b', 'c') :: GEdge('b', 'e') :: GEdge('c', 'e') :: GEdge('d', 'e') :: GEdge('d', 'f') :: GEdge('d', 'g') :: GEdge('e', 'h') :: GEdge('f', 'g') :: GEdge('g', 'h') :: Nil
        )) |> List.size == 14
    }

 
}

