

pub enum MTree[a] {
    case MTree(a, List[MTree[a]])
}

instance ToString[MTree[a]] with ToString[a] {
    pub def toString(l: MTree[a]): String = match l {
        case MTree(x, xs) => "MTree(${x}, ${xs})"
    }
}

instance Eq[MTree[a]] with Eq[a] {
    pub def eq(l1: MTree[a], l2: MTree[a]): Bool = match (l1, l2) {
        case (MTree(x, xs), MTree(y, ys)) => x == y and xs == ys
    }
}

namespace MTrees {
    pub def count(mt : MTree[a]): Int32 =
        let MTree(_, xs) = mt;
        (xs |> List.foldLeft((acc, x) -> acc + count(x), 1))

    pub def display(mt: MTree[Char]): String =
        let MTree(c, xs) = mt;
        "${c}${xs |> List.foldLeft((acc, x) -> "${acc}${display(x)}", "")}^"

    def parseHelper(str: List[Char]): (List[Char], List[MTree[Char]]) =
        match str {
            case '^' :: xs => (xs,  Nil)
            case x :: xs =>
                let (rest0, trees0) = parseHelper(xs);
                let (rest1, trees1) = parseHelper(rest0);
                (rest1, MTree(x, trees0) :: trees1)
            case _ => (Nil, Nil)
        }

    pub def parse(s: String): Option[MTree[Char]] =
        match (s |> String.toList) {
            case Nil      => None
            case _ :: Nil => None
            case str      =>
                let (_, t) = parseHelper(str);
                t |> List.head
        }
}
