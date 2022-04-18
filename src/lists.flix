namespace Lists {
    enum EncodeResult[a]{
        case Single(a),
        case Multiple(Int32, a)
    }

    instance Eq[EncodeResult[a]]  with Eq[a] {
            pub def eq(x: EncodeResult[a], y: EncodeResult[a]): Bool = match (x, y) {
                    case (Single(a), Single(b)) => a == b
                    case (Multiple(la, a), Multiple(lb, b)) => la == lb and a == b
                    case _ => false
            }
    }

    pub def last(l: List[a]): Option[a] = match l {
            case Nil        => None
            case x :: Nil   => Some(x)
            case _ :: rs  => last(rs)
    }

    pub def nextToLast(l: List[a]): Option[a] = match l {
        case Nil            => None
        case _ :: Nil       => None
        case x :: _ :: Nil  => Some(x)
        case _ :: rs        => nextToLast(rs)
    }

    pub def kth(l: List[a], k: Int32): Option[a] = match l {
        case Nil                => None
        case x :: _ if (k == 0) => Some(x)
        case _ :: rs            => if (k < 0) None else kth(rs, k - 1)
    }

    pub def eliminateDuplicates(l: List[a]): List[a] with Eq[a] = match l {
        case Nil => Nil
        case x :: Nil => x :: Nil
        case x :: y :: rs =>
            if (x == y)
                eliminateDuplicates(y :: rs)
            else
                x :: eliminateDuplicates(y :: rs)
    }

    pub def lengthRecursive(l: List[a]): Int32 = match l {
        case Nil       => 0
        case _ :: tail => 1 + lengthRecursive(tail)
    }

    pub def reverseRecursive(l: List[a]): List[a] = match l {
        case Nil       => Nil
        case h :: tail => reverseRecursive(tail) ::: (h :: Nil)
    }

    def reverseR(result: List[a], curList: List[a]): List[a] = match curList {
        case Nil       => result
        case h :: tail => reverseR(h :: result, tail)
    }

    pub def reverseTailRecursive(l: List[a]): List[a] =
        reverseR(Nil: List[a], l)

    def spanR(l: List[a], p: a -> Bool, b: List[a]): (List[a], List[a]) = match l {
        case Nil       => (b, Nil)
        case h :: tail => if (p(h)) spanR(tail, p, h :: b) else (b, l)
    }

    pub def span(l: List[a], p: a -> Bool): (List[a], List[a]) =
        spanR(l, p, Nil)

    pub def pack(l: List[a]): List[List[a]] with Eq[a] = match l {
        case Nil => (Nil) :: Nil
        case h :: _ =>
            match span(l, x -> x == h) {
                case (packed, Nil) => packed :: Nil
                case (packed, next) => packed :: pack(next)
            }
    }
/*
    def pack(l: List[a]): List[List[a]] with Eq[a] = match l {
        case Nil => Nil
        case h :: tail  => List.takeWhile(x -> x == h, h :: tail) :: pack( List.dropWhile(x -> x == h, h :: tail))
    }
*/
    pub def encode(l: List[a]): List[(Int32, a)] with Eq[a] =
        use List.flatMap;
        let* sub = pack(l);
        let len = List.length(sub);
        List.head(sub) |> Option.map(v -> (len, v)) |> Option.toList

    pub def encodeModified(l: List[a]): List[EncodeResult[a]] with Eq[a] =
        encode(l) |> List.map(t -> match t {
                case (1, e)   => Single(e)
                case (len, e) => Multiple(len, e)
            }
        )

    pub def decode(l: List[(Int32, a)]): List[a] =
        use List.flatMap;
        let* (len, e) = l;
        List.repeat(len, e)

    pub def encodeDirect(l: List[a]): List[(Int32, a)] with Eq[a] = match l {
        case Nil => Nil
        case h :: _   =>
            let (packed, next) = span(l, x -> x == h);
            let len = List.length(packed);
            (List.head(packed) |> Option.map(v -> (len, v)) |> Option.toList) ::: encodeDirect(next)
    }

    pub def duplicate(l: List[a]): List[a] =
        use List.flatMap;
        let* v = l;
        v :: v :: Nil

    pub def duplicateN(n: Int32, l: List[a]): List[a] =
        use List.flatMap;
        let* v = l;
        List.repeat(n, v)

    def dropR(i: Int32, n: Int32, l: List[a], b: List[a]): List[a] = match l {
        case Nil       => reverseTailRecursive(b)
        case h :: tail =>
            if (n > 1)
                dropR(i, n - 1, tail, h :: b)
            else if (n == 1)
                dropR(i, i, tail, b)
            else
                reverseTailRecursive(b) ::: l
    }

    pub def drop(n: Int32, l: List[a]): List[a] =
        dropR(n, n, l, Nil)

    def splitR(curN: Int32, curL: List[a], pre: List[a]): (List[a], List[a]) =
        match (curN, curL) {
            case (_, Nil)       => (reverseTailRecursive(pre), Nil)
            case (0, list)      => (reverseTailRecursive(pre), list)
            case (n, h :: tail) => splitR(n - 1, tail, h :: pre)
        }

    pub def split(n: Int32, l: List[a]): (List[a], List[a]) =
        splitR(n, l, Nil)
/*
    def at(i: Int32, xs: List[a]): Option[a] = match (i, xs) {
        case (0, x :: _)  => Some(x)
        case (p, _ :: rs) => at(p - 1, rs)
        case _            => None
    }
*/
    pub def slice(n: Int32, k: Int32, l: List[a]): List[a] = l |> List.drop(n) |> List.take(k - (Int32.max(n, 0)))
    pub def rotate(n: Int32, l: List[a]): List[a] = List.rotateLeft(n, l)
    pub def removeAt(n: Int32, l: List[a]): (List[a], Option[a]) =
        match split(n, l) {
            case (_, Nil)             => (l, None)
            case (left, (e :: right)) => (left ::: (right), Some(e))
        }

    pub def insertAt(e: a, n: Int32, l: List[a]): List[a] =
        let (left, right) = split(n, l);
        left ::: (e :: right)
    pub def range(n: Int32, k: Int32): List[Int32] = List.range(n, k+1)

    def flatMapSublists(f: List[a] -> List[b], l: List[a]): List[b] = match l {
        case Nil                   => Nil
        case (h :: tail) => f(h :: tail) ::: flatMapSublists(f, tail)
    }

    pub def combinations(n: Int32, l: List[a]): List[List[a]] =
        if (n == 0) Nil :: Nil
        else
            flatMapSublists(sl -> match sl {
                case Nil => Nil
                case h :: tail =>
                 combinations(n - 1, tail) |> List.map(x -> h :: x )
         }, l)


    def zipAllHelper(dx: a, dy: b, xs: List[a], ys: List[b], k: List[(a,b)] -> List[(a,b)]): List[(a,b)] = match (xs, ys) {
        case (x :: rs, y :: qs) => zipAllHelper(dx, dy, rs,  qs, ks -> k((x, y)  :: ks))
        case (Nil, y :: qs)     => zipAllHelper(dx, dy, Nil, qs, ks -> k((dx, y) :: ks))
        case (x :: rs, Nil)     => zipAllHelper(dx, dy, rs, Nil, ks -> k((x, dy) :: ks))
        case (Nil, Nil)         => k(Nil)
    }

    pub def zipAll(dx: a, dy: b, xs: List[a], ys: List[b]): List[(a, b)] =
        zipAllHelper(dx, dy, xs, ys, ks -> ks)
}
