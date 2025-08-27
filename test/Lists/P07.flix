// Flatten a nested list structure.
mod Lists.P07 {

    def flatten(l: List[List[a]]): List[a] = List.flatten(l)

    @test
    def testFlatten01(): Bool =
        flatten(
            (1 :: 1 :: Nil) ::
            (2 :: Nil) ::
            (3 :: Nil) ::
            (5 :: 8 :: Nil) :: Nil
        ) == (1 :: 1 :: 2 :: 3 :: 5 :: 8 :: Nil)
}
