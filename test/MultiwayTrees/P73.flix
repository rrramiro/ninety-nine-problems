mod MultiwayTrees.P73 {
    def lispyTree(mt: MTree[Char]): String =
        match mt {
            case MTree.MTree(x, Nil) => "${x}"
            case MTree.MTree(x, ts) => "(${x}${ts |> List.foldLeft((acc, a) -> "${acc} ${lispyTree(a)}", "")})"
        }

    @test
    def testLispyTree01(): Bool =
        lispyTree(MTree.MTree('a', Nil)) == "a"

    @test
    def testLispyTree02(): Bool =
        lispyTree(MTree.MTree('a', MTree.MTree('b', Nil) :: Nil)) == "(a b)"

    @test
    def testLispyTree03(): Bool =
        lispyTree(MTree.MTree('a', MTree.MTree('b', MTree.MTree('c', Nil) :: Nil) :: Nil)) == "(a (b c))"

    @test
    def testLispyTree04(): Bool =
        lispyTree(MTree.MTree('b', MTree.MTree('d', Nil) :: MTree.MTree('e', Nil) :: Nil)) == "(b d e)"

    @test
    def testLispyTree05(): Bool =
        lispyTree(MTree.MTree('a',
            MTree.MTree('f', MTree.MTree('g', Nil) :: Nil) ::
            MTree.MTree('c', Nil) ::
            MTree.MTree('b', MTree.MTree('d', Nil) :: MTree.MTree('e', Nil) :: Nil) ::
            Nil
        )) == "(a (f g) c (b d e))"

    def parseLispyTreeHelper(stack: List[MTree[Char]], tokens: List[Char]): Option[MTree[Char]] =
        match tokens {
            case ')' :: xs =>
                match stack {
                    case x :: Nil                     => Some(x)
                    case tx :: MTree.MTree(y, ty) :: stackp => parseLispyTreeHelper(MTree.MTree(y, ty ::: (tx :: Nil)) :: stackp, xs)
                    case _ => None
                }
            case '(' :: x :: xs => parseLispyTreeHelper(MTree.MTree(x, Nil) :: stack, xs)
            case x :: xs =>
                match stack {
                    case Nil => parseLispyTreeHelper(MTree.MTree(x, Nil) :: Nil, xs)
                    case MTree.MTree(y, t) :: stackp => parseLispyTreeHelper(MTree.MTree(y, t ::: (MTree.MTree(x, Nil) :: Nil ))::stackp, xs)
                }
            case Nil => stack |> List.head
            case _   => None
        }

    def parseLispyTree(s: String): Option[MTree[Char]] =
        s |> String.toList |> List.filter(a -> a != ' ') |> parseLispyTreeHelper(Nil)

    @test
    def testParseLispyTree01(): Bool =
        parseLispyTree("a") == Some(MTree.MTree('a', Nil))

    @test
    def testParseLispyTree02(): Bool =
        parseLispyTree("(a b)") == Some(MTree.MTree('a', MTree.MTree('b', Nil) :: Nil))

    @test
    def testParseLispyTree03(): Bool =
        parseLispyTree("(a (b c))") == Some(MTree.MTree('a', MTree.MTree('b', MTree.MTree('c', Nil) :: Nil) :: Nil))

    @test
    def testParseLispyTree04(): Bool =
        parseLispyTree("(b d e)") == Some(MTree.MTree('b', MTree.MTree('d', Nil) :: MTree.MTree('e', Nil) :: Nil))

    @test
    def testParseLispyTree05(): Bool =
        parseLispyTree("(a (f g) c (b d e))") == Some(MTree.MTree('a',
            MTree.MTree('f', MTree.MTree('g', Nil) :: Nil) ::
            MTree.MTree('c', Nil) ::
            MTree.MTree('b', MTree.MTree('d', Nil) :: MTree.MTree('e', Nil) :: Nil) ::
            Nil
        ))

}
