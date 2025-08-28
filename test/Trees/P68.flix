mod Trees.P68 {

    def preorder(t: Tree[a]) : List[a] =
        match t {
            case Tree.TNil                      => Nil
            case Tree.TNode(value, left, right) => value :: (preorder(left) ::: preorder(right))
        }

    @test
    def testPreorderTree01(): Bool =
       preorder(Trees.parse("a(b(d,e),c(,f(g,)))") |> Option.getWithDefault(Tree.TNil)) == 'a' :: 'b' :: 'd' :: 'e' :: 'c' :: 'f' :: 'g' :: Nil


    def inorder(t: Tree[a]) : List[a] =
        match t {
            case Tree.TNil                      => Nil
            case Tree.TNode(value, left, right) => inorder(left) ::: (value :: inorder(right))
        }

    @test
    def tesInorderTree01(): Bool =
        inorder(Trees.parse("a(b(d,e),c(,f(g,)))") |> Option.getWithDefault(Tree.TNil)) == 'd' :: 'b' :: 'e' :: 'a' :: 'c' :: 'g' :: 'f' :: Nil

    def preInTree(pre: List[a], in: List[a]): Tree[a] with Eq[a] =
        match (pre, in) {
            case (Nil, Nil)                     => Tree.TNil
            case (x :: Nil, y :: Nil) if x == y => Tree.TNode(x, Tree.TNil, Tree.TNil)
            case (x :: xs, io) =>
                let (lio, rio) = Lists.span(io, a -> x != a);
                let (lpo, rpo) = Lists.split(List.length(lio), xs);
                let l = preInTree(lpo, lio);
                let r = preInTree(rpo, rio |> List.drop(1));
                Tree.TNode(x, l, r)
            case _  => Tree.TNil
        }

    @test
    def testPreInTree01(): Bool =
        preInTree(
            'a' :: 'b' :: 'd' :: 'e' :: 'c' :: 'f' :: 'g' :: Nil,
            'd' :: 'b' :: 'e' :: 'a' :: 'c' :: 'g' :: 'f' :: Nil
        ) == Tree.TNode('a', Tree.TNode('b', Tree.TNode('d', Tree.TNil, Tree.TNil), Tree.TNode('e', Tree.TNil, Tree.TNil)), Tree.TNode('c', Tree.TNil, Tree.TNode('f', Tree.TNode('g', Tree.TNil, Tree.TNil), Tree.TNil)))


    @test
    def testPreInTree02(): Bool =
        preInTree(
            'a' :: 'b' :: 'a' :: Nil,
            'b' :: 'a' :: 'a' :: Nil
        ) == Tree.TNode('a', Tree.TNode('b', Tree.TNil, Tree.TNil), Tree.TNode('a', Tree.TNil, Tree.TNil))

}