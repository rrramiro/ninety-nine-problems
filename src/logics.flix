
enum Boolean {
    case False,
    case True
}

instance Eq[Boolean] {
    pub def eq(x: Boolean, y: Boolean): Bool = match (x, y) {
        case (True, True)   => true
        case (False, False) => true
        case _              => false
    }
}

namespace Logics {
    pub def nand(a: Boolean, b: Boolean): Boolean =
        if(a == True) (if(b == True) False else True) else True
    pub def not(a: Boolean): Boolean             = nand(a, True)
    pub def and(a: Boolean, b: Boolean): Boolean = not(nand(a, b))
    pub def or(a: Boolean, b: Boolean): Boolean  = nand(not(a), not(b))
    pub def nor(a: Boolean, b: Boolean): Boolean = not(or(a, b))
    pub def xor(a: Boolean, b: Boolean): Boolean =
        let n = nand(a, b);
        nand(nand(n, a), nand(n, b))
    pub def equ(a: Boolean, b: Boolean): Boolean  = not(xor(a, b))
    pub def impl(a: Boolean, b: Boolean): Boolean = nand(a, not(b))

}
