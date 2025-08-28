
enum Boolean {
    case False,
    case True
}

instance Eq[Boolean] {
    pub def eq(x: Boolean, y: Boolean): Bool = match (x, y) {
        case (Boolean.True, Boolean.True)   => true
        case (Boolean.False, Boolean.False) => true
        case _              => false
    }
}

mod Logics {
    pub def nand(a: Boolean, b: Boolean): Boolean =
        if(a == Boolean.True) (if(b == Boolean.True) Boolean.False else Boolean.True) else Boolean.True

    pub def _not(a: Boolean): Boolean             = Logics.nand(a, Boolean.True)

    pub def _and(a: Boolean, b: Boolean): Boolean = Logics._not(Logics.nand(a, b))

    pub def _or(a: Boolean, b: Boolean): Boolean  = Logics.nand(Logics._not(a), Logics._not(b))

    pub def nor(a: Boolean, b: Boolean): Boolean = Logics._not(Logics._or(a, b))

    pub def _xor(a: Boolean, b: Boolean): Boolean =
        let n = Logics.nand(a, b);
        Logics.nand(Logics.nand(n, a), Logics.nand(n, b))

    pub def equ(a: Boolean, b: Boolean): Boolean  = Logics._not(Logics._xor(a, b))

    pub def impl(a: Boolean, b: Boolean): Boolean = Logics.nand(a, Logics._not(b))

}
