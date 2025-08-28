
enum Tree[a] {
    case TNode(a, Tree[a], Tree[a]),
    case TNil
}

instance ToString[Tree[a]] with ToString[a] {
    pub def toString(t: Tree[a]): String = match t {
        case Tree.TNode(value, left, right) => "TNode(${value}, ${left}, ${right})"
        case Tree.TNil                      => "TNil"
    }
}

instance Eq[Tree[a]] with Eq[a] {
    pub def eq(left: Tree[a], right: Tree[a]): Bool = match (left, right) {
        case (Tree.TNode(v1, l1, r1), Tree.TNode(v2, l2, r2)) => (v1 == v2) and (l1 == l2) and (r1 == r2)
        case (Tree.TNil, Tree.TNil)                           => true
        case _                                      => false
    }
}

pub enum Positioned[a](a, Int32, Int32)

instance Eq[Positioned[a]] with Eq[a] {
    pub def eq(left: Positioned[a], right: Positioned[a]): Bool =
        let Positioned.Positioned(v1, x1, y1) = left;
        let Positioned.Positioned(v2, x2, y2) = right;
        (v1 == v2) and (x1 == x2) and (y1 == y2)
}

instance ToString[Positioned[a]] with ToString[a] {
    pub def toString(p: Positioned[a]): String =
        let Positioned.Positioned(value, x, y) = p;
        "Positioned(${value}, ${x}, ${y})"
}

mod Trees {

    pub def leafs(t: Tree[a]): Int32 = match t {
        case Tree.TNil                 => 0
        case Tree.TNode(_, Tree.TNil, Tree.TNil) => 1
        case Tree.TNode(_, l, r)       => leafs(l) + leafs(r)
    }

    pub def leaves(t: Tree[a]): List[a] = match t {
        case Tree.TNil                 => Nil
        case Tree.TNode(v, Tree.TNil, Tree.TNil) => v :: Nil
        case Tree.TNode(_, l, r)       => leaves(l) ::: leaves(r)
    }

    pub def internals(t: Tree[a]): List[a] = match t {
        case Tree.TNil                 => Nil
        case Tree.TNode(_, Tree.TNil, Tree.TNil) => Nil
        case Tree.TNode(v, l, r)       => v :: (internals(l) ::: internals(r))
    }

    pub def atlevel(level: Int32, t: Tree[a]): List[a] = match t {
        case Tree.TNil                 => Nil
        case Tree.TNode(v, l, r)       => if(level <= 0) v :: Nil else atlevel(level - 1, l) ::: atlevel(level - 1, r)
    }

    pub def isLeaf(t: Tree[a]): Bool = match t {
        case Tree.TNode(_, Tree.TNil, Tree.TNil) => true
        case _                    => false
    }

    pub def nodeCount(t: Tree[a]): Int32 = match t {
        case Tree.TNil           => 0
        case Tree.TNode(_, l, r) => nodeCount(l) + nodeCount(r) + 1
    }

    pub def height(t: Tree[a]): Int32 = match t {
        case Tree.TNil                 => 0
        case Tree.TNode(_, Tree.TNil, Tree.TNil) => 1
        case Tree.TNode(_, l, r)       => Int32.max(height(l), height(r)) + 1
    }

    pub def isHeightBalanced(t: Tree[a]): Bool = match t {
        case Tree.TNode(_, l, r) => 1 >= Int32.abs((height(l) - height(r)))
        case Tree.TNil           => false
    }

    pub def isMirrorOf(l: Tree[a], r: Tree[a]): Bool = match (l, r) {
        case (Tree.TNil, Tree.TNil)                         => true
        case (Tree.TNode(_, l1, r1), Tree.TNode(_, l2, r2)) => isMirrorOf(l1, r2) and isMirrorOf(l2, r1)
        case _                                    => false
    }

    pub def isSymmetric(t: Tree[a]): Bool = match t {
        case Tree.TNil           => true
        case Tree.TNode(_, l, r) => isMirrorOf(l, r)
    }

    pub def insert(x: a, t: Tree[a]): Tree[a] with Order[a] = match t {
        case Tree.TNil           => Tree.TNode(x, Tree.TNil, Tree.TNil)
        case Tree.TNode(y, l, r) =>
            if (x == y) t
            else if(x < y) Tree.TNode(y, insert(x, l), r)
            else Tree.TNode(y, l, insert(x, r))
    }

    pub def fromList(l: List[a]): Tree[a] with Order[a] =
        List.foldLeft((acc, x) -> insert(x, acc), Tree.TNil, l)

    pub def cBalanced(n: Int32, value: a): List[Tree[a]] \ {} =
        if(n < 1) Tree.TNil :: List.Nil
        else if(Int32.modulo(n, 2) == 1) {
            let t = cBalanced(n / 2, value);
            forM(l <- t; r <- t; res <- Tree.TNode(value, l, r) :: List.Nil)
                yield res
        } else if(Int32.modulo(n, 2) == 0)
            forM(
                l <- cBalanced((n - 1) / 2, value);
                g <- cBalanced((n - 1) / 2 + 1, value);
                r <- Tree.TNode(value, l, g) :: Tree.TNode(value, g, l) :: List.Nil
            ) yield r
        else List.Nil


    pub def heightBalanced(i: Int32, x: a): List[Tree[a]] =
        use List.flatMap;
        if(i <= 0) Tree.TNil :: Nil
        else if(i == 1) Tree.TNode(x, Tree.TNil, Tree.TNil) :: Nil
        else {
            let t1 = heightBalanced(i - 1, x);
            let t2 = heightBalanced(i - 2, x);
            {
                forM(tall <- t1; tall2 <- t1; r <- Tree.TNode(x, tall, tall2) :: Nil)
                    yield r
            } ::: {
                forM(short <- t2; tall <- t1; r <- Tree.TNode(x, tall, short) :: Tree.TNode(x, short, tall) :: Nil)
                    yield r
            }
        }

    def generateTree(nodes: Int32, value: a, addr: Int32): Tree[a] =
        if (addr > nodes) Tree.TNil
        else Tree.TNode(value, generateTree(nodes, value, 2 * addr), generateTree(nodes, value,2 * addr + 1))

    pub def completeBinaryTree(nodes: Int32, value: a): Tree[a] =
        generateTree(nodes, value, 1)

    def layoutBinaryTreeInternal(x: Int32, depth: Int32, t: Tree[a]): (Tree[Positioned[a]], Int32) = match t {
        case Tree.TNil                      => (Tree.TNil, x)
        case Tree.TNode(value, left, right) =>
            let (leftTree, myX)    = layoutBinaryTreeInternal(x, depth + 1, left);
            let (rightTree, nextX) = layoutBinaryTreeInternal(myX + 1, depth + 1, right);
            (Tree.TNode(Positioned.Positioned(value, myX, depth), leftTree, rightTree), nextX)
    }

    pub def layoutBinaryTree(t: Tree[a]): Tree[Positioned[a]] =
        let (result, _) = layoutBinaryTreeInternal(1, 1, t);
        result

    def leftmostNodeDepth(t: Tree[a]): Int32 = match t {
        case Tree.TNil           => 0
        case Tree.TNode(_, l, _) => leftmostNodeDepth(l) + 1
    }

    def layoutBinaryTree2Internal(x: Int32, depth: Int32, exp: Int32, t: Tree[a]) : Tree[Positioned[a]] =
        let towExp = Arithmetics.powInt(2, exp) |> Option.getWithDefault(0);
        match t {
            case Tree.TNil                      => Tree.TNil
            case Tree.TNode(value, left, right) =>
                Tree.TNode(
                    Positioned.Positioned(value, x, depth),
                    layoutBinaryTree2Internal(x - towExp, depth + 1, exp - 1, left),
                    layoutBinaryTree2Internal(x + towExp, depth + 1, exp - 1, right)
                )
        }

    pub def layoutBinaryTree2(t: Tree[a]): Tree[Positioned[a]] =
        let d      = Trees.height(t);
        let towExp = ((n: Int32) -> Arithmetics.powInt(2, d - n) |> Option.getWithDefault(0));
        let x0 = List.range(2, leftmostNodeDepth(t) + 1) |> List.map(towExp)  |> List.foldLeft((x, y) -> x + y, 1);
        layoutBinaryTree2Internal(x0, 1, d - 2, t)

    def bounds(t: Tree[a]): List[(Int32, Int32)] = match t {
        case Tree.TNil => Nil
        case Tree.TNode(_, left, right) =>
            (0, 0) :: boundsHelper(left, right)
    }

    def boundsHelper(left: Tree[a], right: Tree[a]): List[(Int32, Int32)] =
        let leftBounds = bounds(left);
        let rightBounds = bounds(right);
        match (leftBounds, rightBounds) {
            case (Nil, Nil) => Nil
            case (lb, Nil) =>
                lb |> List.map(p -> (fst(p) - 1, snd(p) - 1))
            case (Nil, rb) =>
                rb |> List.map(p -> (fst(p) + 1, snd(p) + 1))
            case (lb, rb) =>
                let shift = List.zip(rightBounds, leftBounds) |> List.map(pair ->
                    let ((_, ly), (rx, _)) = pair;
                    (ly - rx) / 2 + 1
                ) |> List.maximum |> Option.getWithDefault(0);
                Lists.zipAll(None, None, lb |> List.map(e -> Some(e)), rb |> List.map(e -> Some(e))) |>
                    List.map(e -> match e {
                        case (Some((a, _)), Some((_, d))) => (a - shift, d + shift)
                        case (Some((a, b)), None) => (a - shift, b - shift)
                        case (None, Some((c, d))) => (c + shift, d + shift)
                        case (None, None) => unreachable!()
                    })
        }

    def layoutBinaryTree3Internal(x: Int32, depth: Int32, t: Tree[a]): Tree[Positioned[a]] =
        match t {
            case Tree.TNil => Tree.TNil
            case Tree.TNode(value, left, right) =>  match bounds(t) {
                case _ :: (bl, br) :: _ =>
                 Tree.TNode(
                    Positioned.Positioned(value, x, depth),
                    layoutBinaryTree3Internal(x + bl, depth + 1, left),
                    layoutBinaryTree3Internal(x + br, depth + 1, right)
                    )
                case _ =>
                 Tree.TNode(
                    Positioned.Positioned(value, x, depth),
                    Tree.TNil,
                    Tree.TNil
                    )
            }
        }


    pub def layoutBinaryTree3(t: Tree[a]): Tree[Positioned[a]] =
        let x = bounds(t) |> List.map(e ->
            let (l, _) = e;
            l
        ) |> List.minimum |> Option.getWithDefault(0) * -1 + 1;
        layoutBinaryTree3Internal(x, 1, t)


    pub def display(t: Tree[a]): String with ToString[a] = match t {
        case Tree.TNil                      => ""
        case Tree.TNode(value, Tree.TNil, Tree.TNil)  => "${value}"
        case Tree.TNode(value, left, right) =>
            let dl = display(left);
            let dr = display(right);
            "${value}(${dl},${dr})"
    }

    def parseHelper(str: List[Char]): Option[(List[Char], Tree[Char])] =
        match str {
            case ',' :: _ => Some((str,  Tree.TNil))
            case ')' :: _ => Some((str,  Tree.TNil))
            case x :: y :: xs if y == ',' or y == ')' => Some((y :: xs,  Tree.TNode(x, Tree.TNil, Tree.TNil)))
            case x :: '(' :: xs =>
                match parseHelper(xs) {
                    case Some((',' :: xss, l)) =>
                        match parseHelper(xss) {
                            case Some((')' :: xsss, r)) => Some((xsss, Tree.TNode(x, l, r)))
                            case _  => None
                        }
                    case _ => None
                }
            case _ => None
        }

    pub def parse(s: String): Option[Tree[Char]] =
        match (s |> String.toList) {
            case Nil      => Some(Tree.TNil)
            case x :: Nil => Some(Tree.TNode(x, Tree.TNil, Tree.TNil))
            case str      =>
                parseHelper(str) |> Option.map(r ->
                    let (_, t) = r;
                    t
                )
        }
}
