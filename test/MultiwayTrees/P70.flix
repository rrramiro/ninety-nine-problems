namespace MultiwayTrees/P70 {
    @test
    def testCount01(): Bool =
        MTrees.count(MTree('a', MTree('f', Nil) :: Nil)) == 2

    @test
    def testDisplay01(): Bool =
        MTrees.display(MTree('a',
            MTree('f', MTree('g', Nil) :: Nil) ::
            MTree('c', Nil) ::
            MTree('b', MTree('d', Nil) :: MTree('e', Nil) :: Nil) ::
            Nil
        )) == "afg^^c^bd^e^^^"

    @test
    def testParse01(): Bool =
        MTrees.parse("afg^^c^bd^e^^^") == Some(MTree('a',
            MTree('f', MTree('g', Nil) :: Nil) ::
            MTree('c', Nil) ::
            MTree('b', MTree('d', Nil) :: MTree('e', Nil) :: Nil) ::
            Nil
        ))
}
