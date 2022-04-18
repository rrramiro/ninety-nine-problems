
namespace DelayLists {

        pub def from(n: Int32): DelayList[Int32] = LCons(n, lazy from(n + 1))

        pub def find(f: a -> Bool, xs: DelayList[a]): Option[a] = match xs {
            case ENil          => None
            case LList(ys)     => find(f, force ys)
            case ECons(h, t)   => if(f(h)) Some(h) else find(f, t)
            case LCons(h, t)   => if(f(h)) Some(h) else find(f, force t)
        }

        pub def takeWhile(f: a -> Bool, xs: DelayList[a]): DelayList[a] = match xs {
            case ENil          => ENil
            case LList(ys)     => takeWhile(f, force ys)
            case ECons(h, t)   => if (f(h)) LCons(h, lazy takeWhile(f, t)) else ENil
            case LCons(h, t)   => if (f(h)) LCons(h, lazy takeWhile(f, force t)) else ENil
        }

        pub def last(xs: DelayList[a]): Option[a] = match xs {
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

        pub def forall(f: a -> Bool, xs: DelayList[a]): Bool = match xs {
                case ENil         => true
                case LList(ys)    => forall(f, force ys)
                case ECons(h, t)  => f(h) and forall(f, t)
                case LCons(h, t)  => f(h) and forall(f, force t)
        }

        pub def filter(f: a -> Bool, xs: DelayList[a]): DelayList[a] = match xs {
                case ENil        => ENil
                case LList(ys)   => filter(f, force ys)
                case ECons(h, t) => if (f(h)) LCons(h, lazy filter(f, t)) else filter(f, t)
                case LCons(h, t) => if (f(h)) LCons(h, lazy filter(f, force t)) else filter(f, force t)
        }
}
