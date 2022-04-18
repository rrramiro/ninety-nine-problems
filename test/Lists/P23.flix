namespace Lists/P23 {
    use Lists.removeAt;

    def randomSelectR(gen: Int32 -> Int32 & Impure, i: Int32, xs: List[a]): List[a] & Impure =
        if (i <= 0) Nil
        else {
            let (rest, x) = removeAt(xs |> List.length |> gen, xs);
            (x |> Option.toList) ::: randomSelectR(gen, i - 1, rest)
        }

    pub def randomSelect(gen: Int32 -> Int32 & Impure, i: Int32, xs: List[a]): List[a] & Impure =
        randomSelectR(gen, i, xs)

    @test
    def testRandomSelect01(): Bool & Impure =
        let r = Random.newWithSeed(123456i64);
        let gen = Random.nextNatWithMax(r);
        randomSelect(gen, 3, "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: "g" :: Nil) ==
            "a" :: "g" :: "d" :: Nil

}
