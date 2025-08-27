// Find out whether a list is a palindrome.
mod Lists.P06 {

    def isPalindrome(l: List[a]): Bool with Eq[a] =
        l == List.reverse(l)

    @test
    def testIsPalindrome01(): Bool =
        isPalindrome(1 :: 2 :: 3 :: 2 :: 1 :: Nil) == true

    @test
    def testIsPalindrome02(): Bool =
        isPalindrome(1 :: 2 :: 3 :: 2 :: 2 :: Nil) == false

    @test
    def testIsPalindrome03(): Bool =
        isPalindrome(1 :: 2 :: 2 :: 1 :: Nil) == true

    @test
    def testIsPalindrome04(): Bool =
        isPalindrome(1 :: 2 :: 1 :: 1 :: Nil) == false

}
