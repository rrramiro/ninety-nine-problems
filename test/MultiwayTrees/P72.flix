mod MultiwayTrees.P72 {
    def postorder(mt: MTree[a]): List[a] =
        let MTree.MTree(x, ts) = mt;
        (ts |> List.flatMap(a -> postorder(a))) ::: List.point(x)

    @test
    def testPostorder01(): Bool =
        postorder(MTree.MTree('a',
            MTree.MTree('f', MTree.MTree('g', Nil) :: Nil) ::
            MTree.MTree('c', Nil) ::
            MTree.MTree('b', MTree.MTree('d', Nil) :: MTree.MTree('e', Nil) :: Nil) ::
            Nil
        )) == 'g' :: 'f' :: 'c' :: 'd' :: 'e' :: 'b' :: 'a' :: Nil
}
