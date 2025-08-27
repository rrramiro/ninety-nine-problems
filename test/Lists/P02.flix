// Find the last but one element of a list.
mod Lists.P02 {
    use Lists.nextToLast;

    @test
    def testNextToLast01(): Bool =
        nextToLast((Nil: List[Int32])) == None

    @test
    def testNextToLast02(): Bool =
        nextToLast(1 :: Nil) == None

    @test
    def testNextToLast03(): Bool =
        nextToLast(1 :: 2 :: Nil) == Some(1)

    @test
    def testNextToLast04(): Bool =
        nextToLast(1 :: 2 :: 3 :: Nil) == Some(2)

}
