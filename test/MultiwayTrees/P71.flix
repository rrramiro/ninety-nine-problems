mod MultiwayTrees.P71 {
    def internalPathLengthHelper(mt: MTree[Char], d: Int32): Int32 =
        let MTree.MTree(_, ts) = mt;
        d + (ts |> List.foldLeft((acc, x) -> acc + internalPathLengthHelper(x, d + 1), 0))

    def internalPathLength(mt: MTree[Char]): Int32 =
        internalPathLengthHelper(mt, 0)

    @test
    def testInternalPathLength01(): Bool =
        internalPathLength(MTree.MTree('a',
            MTree.MTree('f', MTree.MTree('g', Nil) :: Nil) ::
            MTree.MTree('c', Nil) ::
            MTree.MTree('b', MTree.MTree('d', Nil) :: MTree.MTree('e', Nil) :: Nil) ::
            Nil
        )) == 9
}
