namespace MultiwayTrees/P71 {
    def internalPathLengthHelper(mt: MTree[Char], d: Int32): Int32 =
        let MTree(_, ts) = mt;
        d + (ts |> List.foldLeft((acc, x) -> acc + internalPathLengthHelper(x, d + 1), 0))

    def internalPathLength(mt: MTree[Char]): Int32 =
        internalPathLengthHelper(mt, 0)

    @test
    def testInternalPathLength01(): Bool =
        internalPathLength(MTree('a',
            MTree('f', MTree('g', Nil) :: Nil) ::
            MTree('c', Nil) ::
            MTree('b', MTree('d', Nil) :: MTree('e', Nil) :: Nil) ::
            Nil
        )) == 9
}
