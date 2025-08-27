
mod DelayLists {

        pub def startFrom(n: Int32): DelayList[Int32] = 
            DelayList.LCons(n, lazy startFrom(n + 1))

        pub def find(f: a -> Bool, xs: DelayList[a]): Option[a] = match xs {
            case DelayList.ENil          => None
            case DelayList.LList(ys)     => find(f, force ys)
            case DelayList.ECons(h, t)   => if(f(h)) Some(h) else find(f, t)
            case DelayList.LCons(h, t)   => if(f(h)) Some(h) else find(f, force t)
        }

        pub def takeWhile(f: a -> Bool, xs: DelayList[a]): DelayList[a] = match xs {
            case DelayList.ENil          => DelayList.ENil
            case DelayList.LList(ys)     => takeWhile(f, force ys)
            case DelayList.ECons(h, t)   => if (f(h)) DelayList.LCons(h, lazy takeWhile(f, t)) else DelayList.ENil
            case DelayList.LCons(h, t)   => if (f(h)) DelayList.LCons(h, lazy takeWhile(f, force t)) else DelayList.ENil
        }

        pub def last(xs: DelayList[a]): Option[a] = match xs {
            case DelayList.ENil                     => None
            case DelayList.LList(ys)                => last(force ys)
            case DelayList.ECons(h, DelayList.ENil) => Some(h)
            case DelayList.ECons(_, t)              => last(t)
            case DelayList.LCons(h, lt)             =>
                match force lt {
                    case DelayList.ENil => Some(h)
                    case t    => last(t)
                }
        }

        pub def forAll(f: a -> Bool, xs: DelayList[a]): Bool = match xs {
                case DelayList.ENil         => true
                case DelayList.ECons(h, t)  => if (f(h)) forAll(f, t) else false
                case DelayList.LCons(h, t)  => if (f(h)) forAll(f, force t) else false
                case DelayList.LList(ys)    => forAll(f, force ys)
        }

        pub def filter(f: a -> Bool, xs: DelayList[a]): DelayList[a] = match xs {
                case DelayList.ENil        => DelayList.ENil
                case DelayList.LList(ys)   => filter(f, force ys)
                case DelayList.ECons(h, t) => if (f(h)) DelayList.LCons(h, lazy filter(f, t)) else filter(f, t)
                case DelayList.LCons(h, t) => if (f(h)) DelayList.LCons(h, lazy filter(f, force t)) else filter(f, force t)
        }

        pub def take(n: Int32, xs: DelayList[a]): DelayList[a] = 
            if (n <= 0) DelayList.ENil
            else match xs {
                case DelayList.ENil         => DelayList.ENil
                case DelayList.LList(ys)    => take(n, force ys)
                case DelayList.ECons(h, t)  => DelayList.LCons(h, lazy take(n - 1, t))
                case DelayList.LCons(h, t)  => DelayList.LCons(h, lazy take(n - 1, force t))
            }

        pub def toList(xs: DelayList[a]): List[a] =
            match xs {
                case DelayList.ENil                     => Nil
                case DelayList.LList(ys)                => toList(force ys)
                case DelayList.ECons(h, DelayList.ENil) => h :: Nil
                case DelayList.ECons(h, t)              => h :: toList(t)
                case DelayList.LCons(h, lt)             =>
                    match force lt {
                        case DelayList.ENil => h :: Nil
                        case t    => h :: toList(t)
                    }
            }
}
