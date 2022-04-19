namespace Trees/P69 {

    def toDotString(t: Tree[Char]): String =
        match t {
            case TNil           => "."
            case TNode(x, l, r) =>
                "${x}${toDotString(l)}${toDotString(r)}"
        }

    @test
    def toDotStringTest01(): Bool =
        toDotString(Trees.parse("a(b(d,e),c(,f(g,)))") |> Option.getWithDefault(TNil)) == "abd..e..c.fg..."

    def parseDotStringHelper(str: List[Char]): (List[Char], Tree[Char]) =
        match str {
            case '.' :: xs => (xs,  TNil)
            case x :: xs =>
                let (xss, l) = parseDotStringHelper(xs);
                let (xsss, r) = parseDotStringHelper(xss);
                (xsss, TNode(x, l, r))
            case _ => (Nil, TNil)
        }

    pub def parseDotString(s: String): Tree[Char] =
        match (s |> String.toList) {
            case Nil      => TNil
            case str      =>
               let (_, t) = parseDotStringHelper(str);
               t
        }

    @test
    def parseDotStringTest01(): Bool =
        parseDotString("abd..e..c.fg...") == TNode('a', TNode('b', TNode('d', TNil, TNil), TNode('e', TNil, TNil)), TNode('c', TNil, TNode('f', TNode('g', TNil, TNil), TNil)))

}