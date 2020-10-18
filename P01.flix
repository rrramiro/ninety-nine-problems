// Find the last element of a list.
namespace P01 {

    def last(l: List[a]): Option[a] = match l {
        case Nil        => None
        case x :: Nil   => Some(x)
        case _ :: rs  => last(rs)
    }

    @test
    def testLast01(): Bool = 
        last(Nil) == None

    @test
    def testLast02(): Bool = 
        last(1 :: Nil) == Some(1)

    @test
    def testLast03(): Bool = 
        last(1 :: 2 :: Nil) == Some(2)

}
