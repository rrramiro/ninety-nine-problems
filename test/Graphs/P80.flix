mod Graphs.P80 {
    use Graph.Graph;
    use GEdge.GEdge;
    use Adjacency.Adjacency;
    use GNode.GNode;
    use DiGraph.DiGraph;
    use Friendly.Friendly;
    use GArc.GArc;
    use GElem.{GLine, GVert};

    @test
    def testGraphToAdj01(): Bool =
        Graphs.graphToAdj(
            Graph(
                'b' :: 'c' :: 'd' :: 'f' :: 'g' :: 'h' :: 'k' :: Nil,
                GEdge('b','c') :: GEdge('b','f'):: GEdge('c','f'):: GEdge('f','k'):: GEdge('g','h') :: Nil
            )
        ) == Adjacency(
            GNode('b', 'c' :: 'f' :: Nil) :: GNode('c', 'b' :: 'f' :: Nil) :: GNode('d', Nil) :: GNode('f', 'b' :: 'c' :: 'k' :: Nil) :: GNode('g', 'h':: Nil) :: GNode('h', 'g':: Nil) :: GNode('k', 'f':: Nil) :: Nil
        )

    @test
    def testAdjToGraph01(): Bool =
        Graphs.adjToGraph(
            Adjacency(
            GNode('b', 'c' :: 'f' :: Nil) :: GNode('c', 'b' :: 'f' :: Nil) :: GNode('d', Nil) :: GNode('f', 'b' :: 'c' :: 'k' :: Nil) :: GNode('g', 'h':: Nil) :: GNode('h', 'g':: Nil) :: GNode('k', 'f':: Nil) :: Nil
            )
        ) == Graph(
            'b' :: 'c' :: 'd' :: 'f' :: 'g' :: 'h' :: 'k' :: Nil,
            GEdge('b','c') :: GEdge('b','f'):: GEdge('c','f'):: GEdge('f','k'):: GEdge('g','h') :: Nil
        )

    @test
    def testDigraphToAdj01(): Bool =
        Graphs.digraphToAdj(
            DiGraph('r' :: 's' :: 't' :: 'u' :: 'v' :: Nil, GArc('s', 'r') :: GArc('s', 'u') :: GArc('u', 'r') :: GArc('u', 's') :: GArc('v', 'u') :: Nil)
        ) == Adjacency(
            GNode('r', Nil) :: GNode('s', 'r' :: 'u' :: Nil) :: GNode('t', Nil) :: GNode('u', 'r' :: 's' :: Nil) :: GNode('v',  'u' :: Nil) :: Nil
        )

    @test
    def testAdjToDigraph01(): Bool =
        Graphs.adjToDigraph(
            Adjacency(
            GNode('r', Nil) :: GNode('s', 'r' :: 'u' :: Nil) :: GNode('t', Nil) :: GNode('u', 'r' :: 's' :: Nil) :: GNode('v',  'u' :: Nil) :: Nil
            )
        ) == DiGraph('r' :: 's' :: 't' :: 'u' :: 'v' :: Nil, GArc('s', 'r') :: GArc('s', 'u') :: GArc('u', 'r') :: GArc('u', 's') :: GArc('v', 'u') :: Nil)

    @test
    def testDigraphToFri01(): Bool =
        Graphs.digraphToFri(
            DiGraph('r' :: 's' :: 't' :: 'u' :: 'v' :: Nil, GArc('s', 'r') :: GArc('s', 'u') :: GArc('u', 'r') :: GArc('u', 's') :: GArc('v', 'u') :: Nil)
        ) == Friendly(
           GLine('s', 'r') :: GLine('s', 'u') :: GLine('u', 'r') :: GLine('u', 's') :: GLine('v', 'u') :: GVert('t') :: Nil
        )

}
