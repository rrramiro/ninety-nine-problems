mod Lists.P23 {
    use Lists.removeAt;

    def randomSelectR(gen: Int32 -> Int32 \ Random , i: Int32, xs: List[a]): List[a] \ Random   =
        if (i <= 0) Nil
        else {
            let (rest, x) = removeAt(xs |> List.length |> gen, xs);
            (x |> Option.toList) ::: randomSelectR(gen, i - 1, rest)
        }

    pub def randomSelect(gen: Int32 -> Int32 \ Random , i: Int32, xs: List[a]): List[a] \ Random  =
        randomSelectR(gen, i, xs)


    @test
    def testRandomSelect01(): Bool =
        let result = Random.runWithSeed(123456i64, 
            () -> {
                let gen = Randoms.nextInt;
                randomSelect(gen, 3, "a" :: "b" :: "c" :: "d" :: "e" :: "f" :: "g" :: Nil)
            }
        );
        result ==  "b" :: "d" :: "c" :: Nil

}
