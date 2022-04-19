namespace Graphs/P80 {
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
}