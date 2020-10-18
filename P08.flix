// Eliminate consecutive duplicates of list elements.
// If a list contains repeated elements they should be replaced with a single copy of the element. The order of the elements should not be changed.
namespace P08 {

    def eliminateDuplicates(l: List[a]): List[a] = match l {
        case Nil => Nil
        case x :: Nil => x :: Nil
        case x :: y :: rs => 
            if (x == y) 
                eliminateDuplicates(y :: rs)
            else
                x :: eliminateDuplicates(y :: rs)
    }

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
