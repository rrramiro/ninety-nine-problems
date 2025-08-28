
mod Randoms {

    // Get a 31-bit random number (equivalent to next(31) in Java)
    pub def randomInt31(): Int32 \ Random =
        Int32.bitwiseAnd(Random.randomInt32(), 0x7FFFFFFF)

    //  Implementation of Java's Random.nextInt(bound) in Flix
    pub def nextIntMax(bound: Int32): Int32 \ Random =
        if (bound <= 0) bug!("IllegalArgument: bound must be positive")
        else {
            let r = randomInt31();
            let m = bound - 1;
            if (Int32.bitwiseAnd(bound, m) == 0)
                Int64.rightShift(Int32.toInt64(bound) * Int32.toInt64(r), 31) |> Int64.tryToInt32 |> Option.getWithDefault(0)
            else nextIntReject(bound, m, r)
        }

    // Helper function for rejection sampling to ensure uniform distribution
    def nextIntReject(bound: Int32, m: Int32, u: Int32): Int32 \ Random =
        let r = Int32.modulo(u, bound);
        if (u - r + m < 0) nextIntReject(bound, m, randomInt31())
        else r

    pub def randomSelect(i: Int32, xs: List[a]): List[a] \ Random =
        if (i <= 0 or List.isEmpty(xs)) Nil
        else {
            let (rest, x) = Lists.removeAt(xs |> List.length |> nextIntMax, xs);
            (x |> Option.toList) ::: randomSelect(i - 1, rest)
        }

    pub def randomPermute(l: List[a]): List[a] \ Random =
        randomSelect(List.length(l), l)
}