mod Arithmetics.P41 {
    use Arithmetics.goldbach;

    def criteria(n : Int32): Bool = n > 2 and Int32.modulo(n, 2) == 0

    def printGoldbachListLimited(b: Int32, e: Int32, limit: Int32): Unit \ IO = {
        List.range(b, e) |>
        List.filter(criteria) |>
        List.forEach(n -> {
            match goldbach(n) {
                case Some((p1, p2)) if (p1 >= limit) =>
                    println(Int32.toString(n) + " = " + Int32.toString(p1) + " + " + Int32.toString(p2))
                case _ => ()
            }
        })
    }

    def printGoldbachList(b: Int32, e: Int32): Unit \ IO =
        printGoldbachListLimited(b, e, 0)

    @test
    def testprintGoldbachList01(): Unit \ IO  =
        printGoldbachList(9, 20)

    @test
    def testprintGoldbachList02(): Unit \ IO =
        printGoldbachListLimited(1, 2000, 50)


}
