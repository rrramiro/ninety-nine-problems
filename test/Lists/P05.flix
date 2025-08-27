//Reverse a list.
mod Lists.P05 {
    use Lists.reverseRecursive;
    use Lists.reverseTailRecursive;
    
    @test
    def testReverseRecursive01(): Bool =
        reverseRecursive((Nil: List[Int32])) == Nil

    @test
    def testReverseRecursive02(): Bool =
        reverseRecursive(1 :: 2 :: 3 :: 4 :: Nil) == 4 :: 3 :: 2 :: 1 :: Nil


    @test
    def testReverseTailRecursive01(): Bool =
        reverseTailRecursive((Nil: List[Int32])) == Nil

    @test
    def testReverseTailRecursive02(): Bool =
        reverseTailRecursive(1 :: 2 :: 3 :: 4 :: Nil) == 4 :: 3 :: 2 :: 1 :: Nil

}
