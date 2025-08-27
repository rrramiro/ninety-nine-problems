mod Logics.P46 {
    use Logics.{nand, _not, _and, _or, nor, _xor, equ, impl};

    def _bToS(a: Boolean): String = if(a == Boolean.True) "True " else "False"

    def table2(f: (Boolean, Boolean) -> Boolean): Unit \ IO =
        ((Boolean.False, Boolean.False) ::
        (Boolean.False, Boolean.True) ::
        (Boolean.True, Boolean.False) ::
        (Boolean.True, Boolean.True) :: Nil) |>
        List.forEach( x ->
            let (a,b) = x;
            let c = f(a, b);
            println("| " + _bToS(a) + " | " + _bToS(b) + " || " + _bToS(c) + " |")
        )

    @test
    def testnot01(): Bool =
        _not(Boolean.True) == Boolean.False

    @test
    def testnot02(): Bool =
        _not(Boolean.False) == Boolean.True

    @test
    def testnand01(): Bool =
        (((Boolean.False, Boolean.False), Boolean.True) ::
        ((Boolean.False, Boolean.True), Boolean.True) ::
        ((Boolean.True, Boolean.False), Boolean.True) ::
        ((Boolean.True, Boolean.True), Boolean.False) :: Nil) |>
        List.forAll( x ->
            let ((a,b), c) = x;
            nand(a, b) == c
        )

    @test
    def testnand02(): Unit \ IO =
        println("NAND");
        println("--------------------------");
        table2(nand)

    @test
    def testand01(): Bool =
        (((Boolean.False, Boolean.False), Boolean.False) ::
        ((Boolean.False, Boolean.True), Boolean.False) ::
        ((Boolean.True, Boolean.False), Boolean.False) ::
        ((Boolean.True, Boolean.True), Boolean.True) :: Nil) |>
        List.forAll( x ->
            let ((a,b), c) = x;
            _and(a, b) == c
        )

    @test
    def testand02(): Unit \ IO =
        println("AND");
        println("--------------------------");
        table2(_and)

    @test
    def testor01(): Bool =
        (((Boolean.False, Boolean.False), Boolean.False) ::
        ((Boolean.False, Boolean.True), Boolean.True) ::
        ((Boolean.True, Boolean.False), Boolean.True) ::
        ((Boolean.True, Boolean.True), Boolean.True) :: Nil) |>
        List.forAll( x ->
            let ((a,b), c) = x;
            _or(a, b) == c
        )

    @test
    def testor02(): Unit \ IO =
        println("OR");
        println("--------------------------");
        table2(_or)

    @test
    def testnor01(): Bool =
        (((Boolean.False, Boolean.False), Boolean.True) ::
        ((Boolean.False, Boolean.True), Boolean.False) ::
        ((Boolean.True, Boolean.False), Boolean.False) ::
        ((Boolean.True, Boolean.True), Boolean.False) :: Nil) |>
        List.forAll( x ->
            let ((a,b), c) = x;
            nor(a, b) == c
        )

    @test
    def testnor02(): Unit \ IO =
        println("NOR");
        println("--------------------------");
        table2(nor)

    @test
    def testxor01(): Bool =
        (((Boolean.False, Boolean.False), Boolean.False) ::
        ((Boolean.False, Boolean.True), Boolean.True) ::
        ((Boolean.True, Boolean.False), Boolean.True) ::
        ((Boolean.True, Boolean.True), Boolean.False) :: Nil) |>
        List.forAll( x ->
            let ((a,b), c) = x;
            _xor(a,b) == c
        )

    @test
    def testxor02(): Unit \ IO =
        println("XOR");
        println("--------------------------");
        table2(_xor)

    @test
    def testequ01(): Bool =
        (((Boolean.False, Boolean.False), Boolean.True) ::
        ((Boolean.False, Boolean.True), Boolean.False) ::
        ((Boolean.True, Boolean.False), Boolean.False) ::
        ((Boolean.True, Boolean.True), Boolean.True) :: Nil) |>
        List.forAll( x ->
            let ((a,b), c) = x;
            equ(a, b) == c
        )

    @test
    def testequ02(): Unit \ IO =
        println("EQU");
        println("--------------------------");
        table2(equ)

    @test
    def testimpl01(): Bool =
        (((Boolean.False, Boolean.False), Boolean.True) ::
        ((Boolean.False, Boolean.True), Boolean.True) ::
        ((Boolean.True, Boolean.False), Boolean.False) ::
        ((Boolean.True, Boolean.True), Boolean.True) :: Nil) |>
        List.forAll( x ->
            let ((a,b), c) = x;
            impl(a, b) == c
        )

    @test
    def testimpl02(): Unit \ IO =
        println("IMPL");
        println("--------------------------");
        table2(impl)
}
