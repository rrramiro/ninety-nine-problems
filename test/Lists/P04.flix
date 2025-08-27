// Find the number of elements of a list.
mod Lists.P04 {
    use Lists.lengthRecursive;
    @test
    def testLengthRecursive01(): Bool =
        lengthRecursive(Nil) == 0

    @test
    def testLengthRecursive02(): Bool =
        lengthRecursive(1 :: 2 :: 3 :: 4 :: Nil) == 4

}
