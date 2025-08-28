mod DelayLists {
    use DelayList.{ENil, ECons, LCons, LList}

    pub def startFrom(n: Int32): DelayList[Int32] =
        LCons(n, lazy startFrom(n + 1))

    pub def find(f: a -> Bool, xs: DelayList[a]): Option[a] =
        match xs {
            case ENil          => None
            case LList(ys)     => find(f, force ys)
            case ECons(h, t)   => if(f(h)) Some(h) else find(f, t)
            case LCons(h, t)   => if(f(h)) Some(h) else find(f, force t)
        }

    pub def takeWhile(f: a -> Bool, xs: DelayList[a]): DelayList[a] =
        match xs {
            case ENil          => ENil
            case LList(ys)     => takeWhile(f, force ys)
            case ECons(h, t)   => if (f(h)) LCons(h, lazy takeWhile(f, t)) else ENil
            case LCons(h, t)   => if (f(h)) LCons(h, lazy takeWhile(f, force t)) else ENil
        }

    pub def last(xs: DelayList[a]): Option[a] =
        match xs {
            case ENil           => None
            case LList(ys)      => last(force ys)
            case ECons(h, ENil) => Some(h)
            case ECons(_, t)    => last(t)
            case LCons(h, lt)   =>
                match force lt {
                    case ENil => Some(h)
                    case t    => last(t)
                }
        }

    pub def forAll(f: a -> Bool, xs: DelayList[a]): Bool =
        match xs {
            case ENil         => true
            case ECons(h, t)  => if (f(h)) forAll(f, t) else false
            case LCons(h, t)  => if (f(h)) forAll(f, force t) else false
            case LList(ys)    => forAll(f, force ys)
        }

    pub def filter(f: a -> Bool, xs: DelayList[a]): DelayList[a] =
        match xs {
            case ENil        => ENil
            case LList(ys)   => filter(f, force ys)
            case ECons(h, t) => if (f(h)) LCons(h, lazy filter(f, t)) else filter(f, t)
            case LCons(h, t) => if (f(h)) LCons(h, lazy filter(f, force t)) else filter(f, force t)
        }

    pub def take(n: Int32, xs: DelayList[a]): DelayList[a] =
        if (n <= 0) ENil
        else match xs {
            case ENil         => ENil
            case LList(ys)    => take(n, force ys)
            case ECons(h, t)  => LCons(h, lazy take(n - 1, t))
            case LCons(h, t)  => LCons(h, lazy take(n - 1, force t))
        }

    pub def toList(xs: DelayList[a]): List[a] =
        match xs {
            case ENil           => Nil
            case LList(ys)      => toList(force ys)
            case ECons(h, ENil) => h :: Nil
            case ECons(h, t)    => h :: toList(t)
            case LCons(h, lt)   =>
                match force lt {
                    case ENil => h :: Nil
                    case t    => h :: toList(t)
                }
        }
}
