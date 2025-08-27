
mod MultiwayTrees.P70 {
    
    @test
    def testCount01(): Bool =
        MTrees.count(MTree.MTree('a', MTree.MTree('f', Nil) :: Nil)) == 2

    @test
    def testDisplay01(): Bool =
        MTrees.display(MTree.MTree('a',
            MTree.MTree('f', MTree.MTree('g', Nil) :: Nil) ::
            MTree.MTree('c', Nil) ::
            MTree.MTree('b', MTree.MTree('d', Nil) :: MTree.MTree('e', Nil) :: Nil) ::
            Nil
        )) == "afg^^c^bd^e^^^"

    @test
    def testParse01(): Bool =
        MTrees.parse("afg^^c^bd^e^^^") == Some(MTree.MTree('a',
            MTree.MTree('f', MTree.MTree('g', Nil) :: Nil) ::
            MTree.MTree('c', Nil) ::
            MTree.MTree('b', MTree.MTree('d', Nil) :: MTree.MTree('e', Nil) :: Nil) ::
            Nil
        ))
}
