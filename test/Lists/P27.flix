mod Lists.P27 {
    use Lists.combinations;

    pub def difference(xs: List[a], ys: List[a]): List[a] with Eq[a] =
        List.foldRight((x, acc) -> if (not List.memberOf(x, ys)) (x :: acc) else acc, Nil, xs)

    def group(l: List[Int32], ls: List[a]): List[List[List[a]]] with Eq[a] = match l {
        case Nil => Nil :: Nil
        case n :: ns =>
            use List.flatMap;
            forM(c <- combinations(n, ls); r <- group(ns, difference(ls, c)) |> List.map(x -> c :: x))
                yield r
    }

    @test
    def testGroup01(): Bool =
        group(2 :: 1 :: Nil, "a" :: "b" :: "c" :: "d" :: Nil) == (
            (("a" :: "b" :: Nil) :: ("c" :: Nil) :: Nil) ::
            (("a" :: "b" :: Nil) :: ("d" :: Nil) :: Nil) ::
            (("a" :: "c" :: Nil) :: ("b" :: Nil) :: Nil) ::
            (("a" :: "c" :: Nil) :: ("d" :: Nil) :: Nil) ::
            (("a" :: "d" :: Nil) :: ("b" :: Nil) :: Nil) ::
            (("a" :: "d" :: Nil) :: ("c" :: Nil) :: Nil) ::
            (("b" :: "c" :: Nil) :: ("a" :: Nil) :: Nil) ::
            (("b" :: "c" :: Nil) :: ("d" :: Nil) :: Nil) ::
            (("b" :: "d" :: Nil) :: ("a" :: Nil) :: Nil) ::
            (("b" :: "d" :: Nil) :: ("c" :: Nil) :: Nil) ::
            (("c" :: "d" :: Nil) :: ("a" :: Nil) :: Nil) ::
            (("c" :: "d" :: Nil) :: ("b" :: Nil) :: Nil) :: Nil
        )

}
