namespace Logics/P47 {
    use Bool.{⊕, ∧, ∨, →, ↔};

    def _bToS(a: Bool): String = if(a) "true " else "false"

    def table2(f: (Bool, Bool) -> Bool): Unit & Impure =
        ((false, false) ::
        (false, true) ::
        (true, false) ::
        (true, true) :: Nil) |>
        List.foreach( x ->
            let (a,b) = x;
            let c = f(a, b);
            println("| " + _bToS(a) + " | " + _bToS(b) + " || " + _bToS(c) + " |")
        )

    @test
    def testnot01(): Bool =
        not (true) == false
    @test
    def testnot02(): Bool =
        not (false) == true

    @test
    def testand01(): Bool =
        (((false, false), false) ::
        ((false, true), false) ::
        ((true, false), false) ::
        ((true, true), true) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            (a and b) == c
        )

    @test
    def testand02(): Bool =
        (((false, false), false) ::
        ((false, true), false) ::
        ((true, false), false) ::
        ((true, true), true) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            (a ∧ b) == c
        )

    @test
    def testand03(): Unit & Impure =
        println("AND");
        println("--------------------------");
        table2((a, b) -> a and b)

    @test
    def testor01(): Bool =
        (((false, false), false) ::
        ((false, true), true) ::
        ((true, false), true) ::
        ((true, true), true) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            (a or b) == c
        )

    @test
    def testor02(): Bool =
        (((false, false), false) ::
        ((false, true), true) ::
        ((true, false), true) ::
        ((true, true), true) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            (a ∨ b) == c
        )

    @test
    def testor03(): Unit & Impure =
        println("OR");
        println("--------------------------");
        table2((a, b) -> a or b)

    @test
    def testxor01(): Bool =
        (((false, false), false) ::
        ((false, true), true) ::
        ((true, false), true) ::
        ((true, true), false) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            (a ⊕ b) == c
        )

    @test
    def testxor02(): Unit & Impure =
        println("XOR");
        println("--------------------------");
        table2((a, b) -> a ⊕ b)

    @test
    def testequ01(): Bool =
        (((false, false), true) ::
        ((false, true), false) ::
        ((true, false), false) ::
        ((true, true), true) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            (a ↔ b) == c
        )

    @test
    def testequ02(): Unit & Impure =
        println("EQU");
        println("--------------------------");
        table2((a, b) -> a ↔ b)

    @test
    def testimpl01(): Bool =
        (((false, false), true) ::
        ((false, true), true) ::
        ((true, false), false) ::
        ((true, true), true) :: Nil) |>
        List.forall( x ->
            let ((a,b), c) = x;
            a → b == c
        )

    @test
    def testimpl02(): Unit & Impure =
        println("IMPL");
        println("--------------------------");
        table2((a, b) -> a → b)
}
