mod Trees.P69 {

    def toDotString(t: Tree[Char]): String =
        match t {
            case Tree.TNil           => "."
            case Tree.TNode(x, l, r) =>
                "${x}${toDotString(l)}${toDotString(r)}"
        }

    @test
    def toDotStringTest01(): Bool =
        toDotString(Trees.parse("a(b(d,e),c(,f(g,)))") |> Option.getWithDefault(Tree.TNil)) == "abd..e..c.fg..."

    def parseDotStringHelper(str: List[Char]): (List[Char], Tree[Char]) =
        match str {
            case '.' :: xs => (xs,  Tree.TNil)
            case x :: xs =>
                let (xss, l) = parseDotStringHelper(xs);
                let (xsss, r) = parseDotStringHelper(xss);
                (xsss, Tree.TNode(x, l, r))
            case _ => (Nil, Tree.TNil)
        }

    pub def parseDotString(s: String): Tree[Char] =
        match (s |> String.toList) {
            case Nil      => Tree.TNil
            case str      =>
               let (_, t) = parseDotStringHelper(str);
               t
        }

    @test
    def parseDotStringTest01(): Bool =
        parseDotString("abd..e..c.fg...") == Tree.TNode('a', Tree.TNode('b', Tree.TNode('d', Tree.TNil, Tree.TNil), Tree.TNode('e', Tree.TNil, Tree.TNil)), Tree.TNode('c', Tree.TNil, Tree.TNode('f', Tree.TNode('g', Tree.TNil, Tree.TNil), Tree.TNil)))

}