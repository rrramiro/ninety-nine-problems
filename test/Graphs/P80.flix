mod Graphs.P80 {
    @test
    def testGraphToAdj01(): Bool =
        Graphs.graphToAdj(
            Graph.Graph(
                'b' :: 'c' :: 'd' :: 'f' :: 'g' :: 'h' :: 'k' :: Nil,
                GEdge.GEdge('b','c') :: GEdge.GEdge('b','f'):: GEdge.GEdge('c','f'):: GEdge.GEdge('f','k'):: GEdge.GEdge('g','h') :: Nil
            )
        ) == Adjacency.Adjacency(
            GNode.GNode('b', 'c' :: 'f' :: Nil) :: GNode.GNode('c', 'b' :: 'f' :: Nil) :: GNode.GNode('d', Nil) :: GNode.GNode('f', 'b' :: 'c' :: 'k' :: Nil) :: GNode.GNode('g', 'h':: Nil) :: GNode.GNode('h', 'g':: Nil) :: GNode.GNode('k', 'f':: Nil) :: Nil
        )

    @test
    def testAdjToGraph01(): Bool =
        Graphs.adjToGraph(
            Adjacency.Adjacency(
            GNode.GNode('b', 'c' :: 'f' :: Nil) :: GNode.GNode('c', 'b' :: 'f' :: Nil) :: GNode.GNode('d', Nil) :: GNode.GNode('f', 'b' :: 'c' :: 'k' :: Nil) :: GNode.GNode('g', 'h':: Nil) :: GNode.GNode('h', 'g':: Nil) :: GNode.GNode('k', 'f':: Nil) :: Nil
            )
        ) == Graph.Graph(
            'b' :: 'c' :: 'd' :: 'f' :: 'g' :: 'h' :: 'k' :: Nil,
            GEdge.GEdge('b','c') :: GEdge.GEdge('b','f'):: GEdge.GEdge('c','f'):: GEdge.GEdge('f','k'):: GEdge.GEdge('g','h') :: Nil
        )

    @test
    def testDigraphToAdj01(): Bool =
        Graphs.digraphToAdj(
            DiGraph.DiGraph('r' :: 's' :: 't' :: 'u' :: 'v' :: Nil, GArc.GArc('s', 'r') :: GArc.GArc('s', 'u') :: GArc.GArc('u', 'r') :: GArc.GArc('u', 's') :: GArc.GArc('v', 'u') :: Nil)
        ) == Adjacency.Adjacency(
            GNode.GNode('r', Nil) :: GNode.GNode('s', 'r' :: 'u' :: Nil) :: GNode.GNode('t', Nil) :: GNode.GNode('u', 'r' :: 's' :: Nil) :: GNode.GNode('v',  'u' :: Nil) :: Nil
        )

    @test
    def testAdjToDigraph01(): Bool =
        Graphs.adjToDigraph(
            Adjacency.Adjacency(
            GNode.GNode('r', Nil) :: GNode.GNode('s', 'r' :: 'u' :: Nil) :: GNode.GNode('t', Nil) :: GNode.GNode('u', 'r' :: 's' :: Nil) :: GNode.GNode('v',  'u' :: Nil) :: Nil
            )
        ) == DiGraph.DiGraph('r' :: 's' :: 't' :: 'u' :: 'v' :: Nil, GArc.GArc('s', 'r') :: GArc.GArc('s', 'u') :: GArc.GArc('u', 'r') :: GArc.GArc('u', 's') :: GArc.GArc('v', 'u') :: Nil)

    @test
    def testDigraphToFri01(): Bool =
        Graphs.digraphToFri(
            DiGraph.DiGraph('r' :: 's' :: 't' :: 'u' :: 'v' :: Nil, GArc.GArc('s', 'r') :: GArc.GArc('s', 'u') :: GArc.GArc('u', 'r') :: GArc.GArc('u', 's') :: GArc.GArc('v', 'u') :: Nil)
        ) == Friendly.Friendly(
           GElem.GLine('s', 'r') :: GElem.GLine('s', 'u') :: GElem.GLine('u', 'r') :: GElem.GLine('u', 's') :: GElem.GLine('v', 'u') :: GElem.GVert('t') :: Nil
        )

}
