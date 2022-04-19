namespace MultiwayTrees/P73 {
    def lispyTree(mt: MTree[Char]): String =
        match mt {
            case MTree(x, Nil) => "${x}"
            case MTree(x, ts) => "(${x}${ts |> List.foldLeft((acc, a) -> "${acc} ${lispyTree(a)}", "")})"
        }

    @test
    def testLispyTree01(): Bool =
        lispyTree(MTree('a', Nil)) == "a"

    @test
    def testLispyTree02(): Bool =
        lispyTree(MTree('a', MTree('b', Nil) :: Nil)) == "(a b)"

    @test
    def testLispyTree03(): Bool =
        lispyTree(MTree('a', MTree('b', MTree('c', Nil) :: Nil) :: Nil)) == "(a (b c))"

    @test
    def testLispyTree04(): Bool =
        lispyTree(MTree('b', MTree('d', Nil) :: MTree('e', Nil) :: Nil)) == "(b d e)"

    @test
    def testLispyTree05(): Bool =
        lispyTree(MTree('a',
            MTree('f', MTree('g', Nil) :: Nil) ::
            MTree('c', Nil) ::
            MTree('b', MTree('d', Nil) :: MTree('e', Nil) :: Nil) ::
            Nil
        )) == "(a (f g) c (b d e))"

    def parseLispyTreeHelper(stack: List[MTree[Char]], tokens: List[Char]): Option[MTree[Char]] =
        match tokens {
            case ')' :: xs =>
                match stack {
                    case x :: Nil                     => Some(x)
                    case tx :: MTree(y, ty) :: stackp => parseLispyTreeHelper(MTree(y, ty ::: (tx :: Nil)) :: stackp, xs)
                    case _ => None
                }
            case '(' :: x :: xs => parseLispyTreeHelper(MTree(x, Nil) :: stack, xs)
            case x :: xs =>
                match stack {
                    case Nil => parseLispyTreeHelper(MTree(x, Nil) :: Nil, xs)
                    case MTree(y, t) :: stackp => parseLispyTreeHelper(MTree(y, t ::: (MTree(x, Nil) :: Nil ))::stackp, xs)
                }
            case Nil => stack |> List.head
            case _   => None
        }

    def parseLispyTree(s: String): Option[MTree[Char]] =
        s |> String.toList |> List.filter(a -> a != ' ') |> parseLispyTreeHelper(Nil)

    @test
    def testParseLispyTree01(): Bool =
        parseLispyTree("a") == Some(MTree('a', Nil))

    @test
    def testParseLispyTree02(): Bool =
        parseLispyTree("(a b)") == Some(MTree('a', MTree('b', Nil) :: Nil))

    @test
    def testParseLispyTree03(): Bool =
        parseLispyTree("(a (b c))") == Some(MTree('a', MTree('b', MTree('c', Nil) :: Nil) :: Nil))

    @test
    def testParseLispyTree04(): Bool =
        parseLispyTree("(b d e)") == Some(MTree('b', MTree('d', Nil) :: MTree('e', Nil) :: Nil))

    @test
    def testParseLispyTree05(): Bool =
        parseLispyTree("(a (f g) c (b d e))") == Some(MTree('a',
            MTree('f', MTree('g', Nil) :: Nil) ::
            MTree('c', Nil) ::
            MTree('b', MTree('d', Nil) :: MTree('e', Nil) :: Nil) ::
            Nil
        ))

}
