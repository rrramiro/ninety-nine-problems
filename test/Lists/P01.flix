// Find the last element of a list.

namespace Lists/P01 {
    use Lists.last;
    @test
    def testLast01(): Bool =
        last(Nil: List[Int32]) == None

    @test
    def testLast02(): Bool =
        last(1 :: Nil) == Some(1)

    @test
    def testLast03(): Bool =
        last(1 :: 2 :: Nil) == Some(2)

}
