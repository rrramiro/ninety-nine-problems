// Pack consecutive duplicates of list elements into sublists.

namespace Lists/P09 {
    use Lists.pack;
    @test
    def testPack01(): Bool =
        pack("a" :: "a" :: "a" :: "a" :: "b" :: "c" :: "c" :: "a" :: "a" :: "d" :: "e" :: "e" :: "e" :: "e" :: Nil) == (
            ("a" :: "a" :: "a" :: "a" :: Nil) ::
            ("b":: Nil) ::
            ("c" :: "c" :: Nil) ::
            ("a" :: "a" :: Nil) ::
            ("d" :: Nil) ::
            ("e" :: "e" :: "e" :: "e" :: Nil) :: Nil
        )

}
