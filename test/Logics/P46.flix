namespace Logics/P46 {
    use Logics.{nand, not, and, or, nor, xor, equ, impl};

    def _bToS(a: Boolean): String = if(a == True) "True " else "False"

    def table2(f: (Boolean, Boolean) -> Boolean): Unit & Impure =
        ((False, False) ::
        (False, True) ::
        (True, False) ::
        (True, True) :: Nil) |>
        List.foreach( x ->
            let (a,b) = x;
            let c = f(a, b);
            println("| " + _bToS(a) + " | " + _bToS(b) + " || " + _bToS(c) + " |")
        )

    @test
    def testnot01(): Bool =
        not(True) == False

    @test
    def testnot02(): Bool =
        not(False) == True

    @test
    def testnand01(): Bool =
        (((False, False), True) ::
        ((False, True), True) ::
        ((True, False), True) ::
        ((True, True), False) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            nand(a, b) == c
        )

    @test
    def testnand02(): Unit & Impure =
        println("NAND");
        println("--------------------------");
        table2(nand)

    @test
    def testand01(): Bool =
        (((False, False), False) ::
        ((False, True), False) ::
        ((True, False), False) ::
        ((True, True), True) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            and(a, b) == c
        )

    @test
    def testand02(): Unit & Impure =
        println("AND");
        println("--------------------------");
        table2(and)

    @test
    def testor01(): Bool =
        (((False, False), False) ::
        ((False, True), True) ::
        ((True, False), True) ::
        ((True, True), True) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            or(a, b) == c
        )

    @test
    def testor02(): Unit & Impure =
        println("OR");
        println("--------------------------");
        table2(or)

    @test
    def testnor01(): Bool =
        (((False, False), True) ::
        ((False, True), False) ::
        ((True, False), False) ::
        ((True, True), False) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            nor(a, b) == c
        )

    @test
    def testnor02(): Unit & Impure =
        println("NOR");
        println("--------------------------");
        table2(nor)

    @test
    def testxor01(): Bool =
        (((False, False), False) ::
        ((False, True), True) ::
        ((True, False), True) ::
        ((True, True), False) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            xor(a,b) == c
        )

    @test
    def testxor02(): Unit & Impure =
        println("XOR");
        println("--------------------------");
        table2(xor)

    @test
    def testequ01(): Bool =
        (((False, False), True) ::
        ((False, True), False) ::
        ((True, False), False) ::
        ((True, True), True) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            equ(a, b) == c
        )

    @test
    def testequ02(): Unit & Impure =
        println("EQU");
        println("--------------------------");
        table2(equ)

    @test
    def testimpl01(): Bool =
        (((False, False), True) ::
        ((False, True), True) ::
        ((True, False), False) ::
        ((True, True), True) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            impl(a, b) == c
        )

    @test
    def testimpl02(): Unit & Impure =
        println("IMPL");
        println("--------------------------");
        table2(impl)
}
