
mod Arithmetics {

    pub def gcd(i: Int32, j: Int32): Int32 =
        if (j == 0) i else gcd(j, Int32.modulo(i, j))

    pub def isCoprimeTo(x: Int32, y: Int32): Bool = gcd(y, x) == 1

    pub def totient(i: Int32): Int32 =
        List.range(1, i) |>
        List.map(x -> if (isCoprimeTo(x, i)) 1 else 0 ) |>
        List.foldLeft(a -> b -> a + b, 0)

    pub def totientPrimeFactor(i: Int32): Option[Int32] =
        primeFactorMultiplicity(i) |>
        List.foldLeft(((accOpt: Option[Int32], x) ->
            let (p, m) = x;
            powInt(p, m - 1) |> Option.zip(accOpt) |> Option.map(y ->
                let (r, u) = y;
                r * (p - 1) * u
            )
        ), Some(1))

    pub def isPrime(p: Int32): Bool =
        DelayLists.startFrom(2) |>
        DelayLists.take(p - 2) |>
        DelayLists.forAll(x -> Int32.modulo(p, x) != 0)

    def primes(): DelayList[Int32] =
        DelayLists.startFrom(2) |>
        DelayLists.filter(isPrime)

    pub def primeFactorsRec(i: Int32, j: DelayList[Int32], js: List[Int32]): List[Int32] = match j {
        case DelayList.ENil                    => Nil
        case DelayList.LList(ys)               => primeFactorsRec(i, force ys, js)
        case DelayList.ECons(h, tail)          =>
            if (Int32.modulo(i, h) == 0) primeFactorsRec(i / h, j, h :: js)
            else if (i > h) primeFactorsRec(i, tail, js)
            else List.reverse(js)
        case DelayList.LCons(h, t)             =>
            let tail = force t;
            if (Int32.modulo(i, h) == 0) primeFactorsRec(i / h, j, h :: js)
            else if (i > h) primeFactorsRec(i, tail, js)
            else List.reverse(js)
    }

    pub def primeFactors(i: Int32): List[Int32] =
        primeFactorsRec(i, primes(), Nil)

    pub def primeFactorMultiplicity(i: Int32): List[(Int32, Int32)] =
        let pf = primeFactors(i);
        Lists.encode(pf) |> List.map(e -> {
            let (l, r) = e;
            (r, l)
        })

    pub def powInt(l: Int32, r: Int32): Option[Int32] =
        let p = Float64.pow(base = Int32.toFloat64(l), Int32.toFloat64(r));
        Float64.tryToInt32(p)

    pub def phi(i: Int32): Option[Int32] =
        primeFactorMultiplicity(i) |> List.foldLeft(((accOpt, x) ->
            let (l, r) = x;
            powInt(l, r - 1) |> Option.zip(accOpt) |> Option.map(y ->
                let (acc, u) = y;
                (l - 1) * u * acc
            )
        ), Some(1))

    pub def primesInRange(l: Int32, r: Int32): List[Int32] =
        primes() |>
        DelayLists.filter(x -> x >= l ) |>
        DelayLists.takeWhile(x -> x <= r) |>
        DelayList.toList

    pub def goldbach(i: Int32): Option[(Int32, Int32)] =
        primes() |>
        DelayLists.filter(x -> x < i) |>
        DelayLists.find(x -> isPrime(i - x) and x != (i - x)) |>
        Option.map(p1 -> (p1, i - p1))
}
