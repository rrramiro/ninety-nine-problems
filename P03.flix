// Find the K'th element of a list.
namespace P03 {
    def kth(l: List[a], k: Int): Option[a] = match l {
        case Nil                => None
        case x :: _ if (k == 0) => Some(x)
        case _ :: rs            => if (k < 0) None else kth(rs, k - 1)
    }

    @test
    def testkth01(): Bool = 
        kth(Nil, 0) == None

    @test
    def testkth02(): Bool = 
        kth(1 :: 2 :: 3 :: 4 :: Nil, 0) == Some(1)

    @test
    def testkth03(): Bool = 
        kth(1 :: 2 :: 3 :: 4 :: Nil, 1) == Some(2)

    @test
    def testkth04(): Bool = 
        kth(1 :: 2 :: 3 :: 4 :: Nil, 2) == Some(3)

    @test
    def testkth05(): Bool = 
        kth(1 :: 2 :: 3 :: 4 :: Nil, 3) == Some(4)

    @test
    def testkth06(): Bool = 
        kth(1 :: 2 :: 3 :: 4 :: Nil, 5) == None
}
