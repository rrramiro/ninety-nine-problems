namespace MultiwayTrees/P72 {
    def postorder(mt: MTree[a]): List[a] =
        let MTree(x, ts) = mt;
        (ts |> List.flatMap(a -> postorder(a))) ::: List.point(x)

    @test
    def testPostorder01(): Bool =
        postorder(MTree('a',
            MTree('f', MTree('g', Nil) :: Nil) ::
            MTree('c', Nil) ::
            MTree('b', MTree('d', Nil) :: MTree('e', Nil) :: Nil) ::
            Nil
        )) == 'g' :: 'f' :: 'c' :: 'd' :: 'e' :: 'b' :: 'a' :: Nil
}
