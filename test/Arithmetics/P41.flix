namespace Arithmetics/P41 {
    use Arithmetics.goldbach;

    def printGoldbachListLimited(b: Int32, e: Int32, limit: Int32): Unit & Impure = {
        List.range(b, e) |>
        List.filter(n -> n > 2 and n % 2 == 0) |>
        List.foreach(n -> {
            match goldbach(n) {
                case Some((p1, p2)) if (p1 >= limit) =>
                    println(Int32.toString(n) + " = " + Int32.toString(p1) + " + " + Int32.toString(p2))
                case _ => ()
            }
        })
    }

    def printGoldbachList(b: Int32, e: Int32): Unit & Impure =
        printGoldbachListLimited(b, e, 0)

    @test
    def testprintGoldbachList01(): Unit & Impure  =
        printGoldbachList(9, 20)

    @test
    def testprintGoldbachList02(): Unit & Impure =
        printGoldbachListLimited(1, 2000, 50)


}
