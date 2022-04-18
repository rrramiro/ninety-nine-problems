namespace Lists/P25 {
    use Lists/P23.randomSelect;
    def randomPermute(gen: Int32 -> Int32 & Impure, l: List[a]): List[a] & Impure =
        randomSelect(gen, List.length(l), l)

    @test
    def testRandomPermute01(): Bool & Impure =
        let r = Random.newWithSeed(123456i64);
        let gen = Random.nextNatWithMax(r);
        randomPermute(gen, "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: Nil) ==
            "d" :: "c":: "f" :: "b" :: "a" :: "e" :: Nil
}
