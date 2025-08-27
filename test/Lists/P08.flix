// Eliminate consecutive duplicates of list elements.
// If a list contains repeated elements they should be replaced with a single copy of the element. The order of the elements should not be changed.
mod Lists.P08 {
    use Lists.eliminateDuplicates;
    @test
    def testEliminateDuplicates01(): Bool =
        eliminateDuplicates(1 :: 1 :: Nil) == 1 :: Nil

    @test
    def testEliminateDuplicates02(): Bool =
        eliminateDuplicates(1 :: 1 :: 1 :: 1 :: Nil) == 1 :: Nil

    @test
    def testEliminateDuplicates03(): Bool =
        eliminateDuplicates(1 :: 1 :: 2 :: 2 :: Nil) == 1 :: 2 :: Nil

    @test
    def testEliminateDuplicates04(): Bool =
        eliminateDuplicates(1 :: 1 :: 2 :: 2 :: 3 :: 3 :: Nil) == 1 :: 2 :: 3 :: Nil

}
