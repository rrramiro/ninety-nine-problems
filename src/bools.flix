mod Bools {
    pub def ∧(x: Bool, y: Bool): Bool = x and y
    pub def ∨(x: Bool, y: Bool): Bool = x or y
    pub def →(x: Bool, y: Bool): Bool = not x or y
    pub def ↔(x: Bool, y: Bool): Bool = (x → y) and (y → x)
    pub def ⊕(x: Bool, y: Bool): Bool = (x or y) and not (x and y)
}