namespace Lists/P24 {
    use Lists/P23.randomSelect;
    def lotto(gen: Int32 ~> Int32, count: Int, max: Int): List[Int] & Impure=
        randomSelect(gen, count, List.range(1, max + 1))

    @test
    def testLotto01(): Bool & Impure =
        let r = Random.newWithSeed(123456i64);
        let gen = Random.nextNatWithMax(r);
        lotto(gen, 6, 49) == 1 :: 25 :: 8 :: 49 :: 32 :: 5 :: Nil
}
