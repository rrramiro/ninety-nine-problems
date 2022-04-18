namespace Trees/P67 {

    def display(t: Tree[a]): String with ToString[a] = match t {
        case TNil                      => ""
        case TNode(value, TNil, TNil)  => "${value}"
        case TNode(value, left, right) => 
            let dl = display(left);
            let dr = display(right);
            "${value}(${dl},${dr})"
    }

    @test
    def testDisplayTree01(): Bool =
        display(
            TNode("a", TNode("b", TNode("d", TNil, TNil), TNode("e", TNil, TNil)), TNode("c", TNil, TNode("f", TNode("g", TNil, TNil), TNil)))
        ) == "a(b(d,e),c(,f(g,)))"
/*
TODO
    def parse(str: String): Tree[String] & Impure = {
        let a = str |> String.toArray |> Array.toList;
        println(a);
        TNode(str, TNil, TNil)
    }

    @test 
    def testParseTree01(): Bool & Impure =
        parse("a(b(d,e),c(,f(g,)))") ==
            TNode("a", TNode("b", TNode("d", TNil, TNil), TNode("e", TNil, TNil)), TNode("c", TNil, TNode("f", TNode("g", TNil, TNil), TNil)))
*/
}
