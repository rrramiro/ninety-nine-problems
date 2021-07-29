namespace Logics/P48 {
    use Bool.{⊕, ∧, ∨, →, ↔};

    def _bToS(a: Bool): String = if(a) "true " else "false"

    def table3(f: (Bool, Bool, Bool) -> Bool): Unit & Impure = {
        use List.flatMap;
        let values = true :: false :: Nil;
        let* a = values;
        let* b = values;
        let* c = values;
        let d = f(a, b, c);
        ("| " + _bToS(a) + " | " + _bToS(b) + " | " + _bToS(c) + " || " + _bToS(d) + " |") :: Nil
    } |> List.foreach(println)

    @test
    def testtable301(): Unit & Impure =
        println("----------------------------------");
        table3((a, b, c) -> a and (b or c) ↔ a and b or a and c)
}
