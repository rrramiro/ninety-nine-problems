
enum Tree[a] {
    case TNode(a, Tree[a], Tree[a]),
    case TNil
}

instance ToString[Tree[a]] with ToString[a] {
    pub def toString(t: Tree[a]): String = match t {
        case TNode(value, left, right) => "TNode(${value}, ${left}, ${right})"
        case TNil                      => "TNil"
    }
}

instance Eq[Tree[a]] with Eq[a] {
    pub def eq(left: Tree[a], right: Tree[a]): Bool = match (left, right) {
        case (TNode(v1, l1, r1), TNode(v2, l2, r2)) => (v1 == v2) and (l1 == l2) and (r1 == r2)
        case (TNil, TNil)                           => true
        case _                                      => false
    }
}

opaque type Positioned[a] = (a, Int32, Int32)

instance Eq[Positioned[a]] with Eq[a] {
    pub def eq(left: Positioned[a], right: Positioned[a]): Bool =
        let Positioned(v1, x1, y1) = left;
        let Positioned(v2, x2, y2) = right;
        (v1 == v2) and (x1 == x2) and (y1 == y2)
}

instance ToString[Positioned[a]] with ToString[a] {
    pub def toString(p: Positioned[a]): String =
        let Positioned(value, x, y) = p;
        "Positioned(${value}, ${x}, ${y})"
}

namespace Trees {

    pub def leafs(t: Tree[a]): Int32 = match t {
        case TNil                 => 0
        case TNode(_, TNil, TNil) => 1
        case TNode(_, l, r)       => leafs(l) + leafs(r)
    }

    pub def leaves(t: Tree[a]): List[a] = match t {
        case TNil                 => Nil
        case TNode(v, TNil, TNil) => v :: Nil
        case TNode(_, l, r)       => leaves(l) ::: leaves(r)
    }

    pub def internals(t: Tree[a]): List[a] = match t {
        case TNil                 => Nil
        case TNode(_, TNil, TNil) => Nil
        case TNode(v, l, r)       => v :: (internals(l) ::: internals(r))
    }

    pub def atlevel(level: Int32, t: Tree[a]): List[a] = match t {
        case TNil                 => Nil
        case TNode(v, l, r)       => if(level <= 0) v :: Nil else atlevel(level - 1, l) ::: atlevel(level - 1, r)
    }

    pub def isLeaf(t: Tree[a]): Bool = match t {
        case TNode(_, TNil, TNil) => true
        case _                    => false
    }

    pub def nodeCount(t: Tree[a]): Int32 = match t {
        case TNil           => 0
        case TNode(_, l, r) => nodeCount(l) + nodeCount(r) + 1
    }

    pub def height(t: Tree[a]): Int32 = match t {
        case TNil                 => 0
        case TNode(_, TNil, TNil) => 1
        case TNode(_, l, r)       => Int32.max(height(l), height(r)) + 1
    }

    pub def isHeightBalanced(t: Tree[a]): Bool = match t {
        case TNode(_, l, r) => 1 >= Int32.abs((height(l) - height(r)))
        case TNil           => false
    }

    pub def isMirrorOf(l: Tree[a], r: Tree[a]): Bool = match (l, r) {
        case (TNil, TNil)                         => true
        case (TNode(_, l1, r1), TNode(_, l2, r2)) => isMirrorOf(l1, r2) and isMirrorOf(l2, r1)
        case _                                    => false
    }

    pub def isSymmetric(t: Tree[a]): Bool = match t {
        case TNil           => true
        case TNode(_, l, r) => isMirrorOf(l, r)
    }

    pub def insert(x: a, t: Tree[a]): Tree[a] with Order[a] = match t {
        case TNil           => TNode(x, TNil, TNil)
        case TNode(y, l, r) =>
            if (x == y) t
            else if(x < y) TNode(y, insert(x, l), r)
            else TNode(y, l, insert(x, r))
    }

    pub def fromList(l: List[a]): Tree[a] with Order[a] =
        List.foldLeft((acc, x) -> insert(x, acc), TNil, l)

    pub def cBalanced(n: Int32, value: a): List[Tree[a]] =
        use List.flatMap;
        if(n < 1) TNil :: Nil
        else if(n % 2 == 1) {
            let t = cBalanced(n / 2, value);
            let* l = t;
            let* r = t;
            TNode(value, l, r) :: Nil
        } else if(n % 2 == 0)
            let* l = cBalanced((n - 1) / 2, value);
            let* g = cBalanced((n - 1) / 2 + 1, value);
            TNode(value, l, g) :: TNode(value, g, l) :: Nil
        else Nil


    pub def heightBalanced(i: Int, x: a): List[Tree[a]] =
        use List.flatMap;
        if(i <= 0) TNil :: Nil
        else if(i == 1) TNode(x, TNil, TNil) :: Nil
        else {
            let t1 = heightBalanced(i - 1, x);
            let t2 = heightBalanced(i - 2, x);
            {
                let* tall = t1;
                let* tall2 = t1;
                TNode(x, tall, tall2) :: Nil
            } ::: {
                let* short = t2;
                let* tall = t1;
                TNode(x, tall, short) :: TNode(x, short, tall) :: Nil
            }
        }

    def generateTree(nodes: Int32, value: a, addr: Int32): Tree[a] =
        if (addr > nodes) TNil
        else TNode(value, generateTree(nodes, value, 2 * addr), generateTree(nodes, value,2 * addr + 1))

    pub def completeBinaryTree(nodes: Int32, value: a): Tree[a] =
        generateTree(nodes, value, 1)

    def layoutBinaryTreeInternal(x: Int, depth: Int, t: Tree[a]): (Tree[Positioned[a]], Int32) = match t {
        case TNil                      => (TNil, x)
        case TNode(value, left, right) =>
            let (leftTree, myX)    = layoutBinaryTreeInternal(x, depth + 1, left);
            let (rightTree, nextX) = layoutBinaryTreeInternal(myX + 1, depth + 1, right);
            (TNode(Positioned(value, myX, depth), leftTree, rightTree), nextX)
    }

    pub def layoutBinaryTree(t: Tree[a]): Tree[Positioned[a]] =
        let (result, _) = layoutBinaryTreeInternal(1, 1, t);
        result

    def leftmostNodeDepth(t: Tree[a]): Int32 = match t {
        case TNil           => 0
        case TNode(_, l, _) => leftmostNodeDepth(l) + 1
    }

    def layoutBinaryTree2Internal(x: Int32, depth: Int32, exp: Int32, t: Tree[a]) : Tree[Positioned[a]] =
        let towExp = Option.getWithDefault(Arithmetics.powInt(2, exp), 0);
        match t {
            case TNil                      => TNil
            case TNode(value, left, right) =>
                TNode(
                    Positioned(value, x, depth),
                    layoutBinaryTree2Internal(x - towExp, depth + 1, exp - 1, left),
                    layoutBinaryTree2Internal(x + towExp, depth + 1, exp - 1, right)
                )
        }

    pub def layoutBinaryTree2(t: Tree[a]): Tree[Positioned[a]] =
        let d      = Trees.height(t);
        let towExp = ((n: Int32) -> Option.getWithDefault(Arithmetics.powInt(2, d - n), 0));
        let x0 = List.range(2, leftmostNodeDepth(t) + 1) |> List.map(towExp)  |> List.foldLeft((x, y) -> x + y, 1);
        layoutBinaryTree2Internal(x0, 1, d - 2, t)

    def bounds(t: Tree[a]): List[(Int32, Int32)] = match t {
        case TNil                  => Nil
        case TNode(_, left, right) => (0, 0) :: (
            match (bounds(left), bounds(right))  {
                case (Nil, Nil) => Nil
                case (lb, Nil)  => lb |> List.map(b ->
                    let (l, r) = b;
                    (l - 1, r - 1)
                )
                case (Nil, rb)  => rb |> List.map(b ->
                    let (l, r) = b;
                    (l + 1, r + 1)
                )
                case (lb, rb) => {
                let shift: Int32 = Option.getWithDefault(List.zip(rb, lb) |> List.map(e ->
                    let ((_,ly), (rx, _)) = e;
                    (ly - rx) / 2 + 1
                ) |> List.maximum, 0) ;
                Lists.zipAll(None, None, lb |> List.map(e -> Some(e)), rb |> List.map(e -> Some(e))) |>
                    List.map(e -> match e {
                    case (Some((a, _)), Some((_, d))) => (a - shift, d + shift)
                    case (Some((a, b)), None)         => (a - shift, b - shift)
                    case (None, Some((c, d)))         => (c + shift, d + shift)
                    case (None, None)                 => unreachable!()
                    })
                }
            }
        )
    }

    def layoutBinaryTree3Internal(x: Int32, depth: Int32, t: Tree[a]): Tree[Positioned[a]] =
        match t {
            case TNil => TNil
            case TNode(value, left, right) =>  match bounds(t) {
                case _ :: (bl, br) :: _ =>
                 TNode(
                    Positioned(value, x, depth),
                    layoutBinaryTree3Internal(x + bl, depth + 1, left),
                    layoutBinaryTree3Internal(x + br, depth + 1, right)
                    )
                case _ =>
                 TNode(
                    Positioned(value, x, depth),
                    TNil,
                    TNil
                    )
            }
        }


    pub def layoutBinaryTree3(t: Tree[a]): Tree[Positioned[a]] =
        let x = Option.getWithDefault(bounds(t) |> List.map(e ->
            let (l, _) = e;
            l
        ) |> List.minimum, 0) * -1 + 1;
        layoutBinaryTree3Internal(x, 1, t)


}
