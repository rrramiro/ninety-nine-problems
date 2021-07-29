// Find the K'th element of a list.
// The first element in the list is number 0.
namespace Lists/P03 {
    use Lists.kth;
    @test
    def testKth01(): Bool =
        kth(Nil: List[Int32], 0) == None

    @test
    def testKth02(): Bool =
        kth(1 :: 2 :: 3 :: 4 :: Nil, 0) == Some(1)

    @test
    def testKth03(): Bool =
        kth(1 :: 2 :: 3 :: 4 :: Nil, 1) == Some(2)

    @test
    def testKth04(): Bool =
        kth(1 :: 2 :: 3 :: 4 :: Nil, 2) == Some(3)

    @test
    def testKth05(): Bool =
        kth(1 :: 2 :: 3 :: 4 :: Nil, 3) == Some(4)

    @test
    def testKth06(): Bool =
        kth(1 :: 2 :: 3 :: 4 :: Nil, 5) == None
}
