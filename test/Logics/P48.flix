mod Logics.P48 {
    use Bool.{⊕, ∧, ∨, →, ↔};

    def _bToS(a: Bool): String = if(a) "true " else "false"

    def table3(f: (Bool, Bool, Bool) -> Bool): Unit \ IO = {
        use List.flatMap;
        let values = true :: false :: Nil;
        forM(
            a <- values;
            b <- values;
            c <- values;
            d = f(a, b, c);
            r <- (("| " + _bToS(a) + " | " + _bToS(b) + " | " + _bToS(c) + " || " + _bToS(d) + " |") :: Nil))
            yield r
    } |> List.forEach(println)

    @test
    def testtable301(): Unit \ IO =
        println("----------------------------------");
        table3((a, b, c) -> a and (b or c) ↔ a and b or a and c)
}
