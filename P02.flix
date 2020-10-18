// Find the last but one element of a list.
namespace P02 {

    def nextToLast(l: List[a]): Option[a] = match l {
        case Nil            => None
        case _ :: Nil       => None
        case x :: _ :: Nil  => Some(x)
        case _ :: rs        => nextToLast(rs)
    }

    @test
    def testNextToLast01(): Bool = 
        nextToLast(Nil) == None

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
