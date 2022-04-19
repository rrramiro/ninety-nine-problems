namespace Trees/P68 {

    def preorder(t: Tree[a]) : List[a] =
        match t {
            case TNil                      => Nil
            case TNode(value, left, right) => value :: (preorder(left) ::: preorder(right))
        }

    @test
    def testPreorderTree01(): Bool =
       preorder(Trees.parse("a(b(d,e),c(,f(g,)))") |> Option.getWithDefault(TNil)) == 'a' :: 'b' :: 'd' :: 'e' :: 'c' :: 'f' :: 'g' :: Nil


    def inorder(t: Tree[a]) : List[a] =
        match t {
            case TNil                      => Nil
            case TNode(value, left, right) => inorder(left) ::: (value :: inorder(right))
        }
    
    @test 
    def tesInorderTree01(): Bool =
        inorder(Trees.parse("a(b(d,e),c(,f(g,)))") |> Option.getWithDefault(TNil)) == 'd' :: 'b' :: 'e' :: 'a' :: 'c' :: 'g' :: 'f' :: Nil

    def preInTree(pre: List[a], in: List[a]): Tree[a] with Eq[a] =
        match (pre, in) {
            case (Nil, Nil)                     => TNil
            case (x :: Nil, y :: Nil) if x == y => TNode(x, TNil, TNil)
            case (x :: xs, io) =>
                let (lio, rio) = Lists.span(io, a -> x != a);
                let (lpo, rpo) = Lists.split(List.length(lio), xs);
                let l = preInTree(lpo, lio);
                let r = preInTree(rpo, rio |> List.drop(1));
                TNode(x, l, r)
            case _  => TNil
        }

    @test
    def testPreInTree01(): Bool =
        preInTree(
            'a' :: 'b' :: 'd' :: 'e' :: 'c' :: 'f' :: 'g' :: Nil,
            'd' :: 'b' :: 'e' :: 'a' :: 'c' :: 'g' :: 'f' :: Nil
        ) == TNode('a', TNode('b', TNode('d', TNil, TNil), TNode('e', TNil, TNil)), TNode('c', TNil, TNode('f', TNode('g', TNil, TNil), TNil)))


    @test
    def testPreInTree02(): Bool =
        preInTree(
            'a' :: 'b' :: 'a' :: Nil,
            'b' :: 'a' :: 'a' :: Nil
        ) == TNode('a', TNode('b', TNil, TNil), TNode('a', TNil, TNil))

}