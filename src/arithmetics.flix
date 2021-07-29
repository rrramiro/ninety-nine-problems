
namespace Arithmetics {

    pub def gcd(i: Int32, j: Int32): Int32 =
        if (j == 0) i else gcd(j, i % j)

    pub def isCoprimeTo(x: Int32, y: Int32): Bool = gcd(y, x) == 1

    pub def totient(i: Int32): Int32 =
        List.range(1, i) |>
        List.map(x -> if (isCoprimeTo(x, i)) 1 else 0 ) |>
        List.foldLeft(a -> b -> a + b, 0)

    pub def totientPrimeFactor(i: Int32): Option[Int32] =
        primeFactorMultiplicity(i) |>
        List.foldLeft(((accOpt, x) ->
            let (p, m) = x;
            powInt(p, m - 1) |> Option.map2((r, u) -> r * (p - 1) * u, accOpt)
        ), Some(1))

    pub def isPrime(p: Int32): Bool =
        LazyLists.from(2) |>
        LazyList.take(p - 2) |>
        LazyLists.forall(x -> p % x != 0)

    def primes(): LazyList[Int32] =
        LazyLists.from(2) |>
        LazyLists.filter(isPrime)

    pub def primeFactorsRec(i: Int32, j: LazyList[Int32], js: List[Int32]): List[Int32] = match j {
        case ENil                    => Nil
        case LList(ys)               => primeFactorsRec(i, force ys, js)
        case ECons(h, tail)          =>
            if (i % h == 0) primeFactorsRec(i / h, j, h :: js)
            else if (i > h) primeFactorsRec(i, tail, js)
            else List.reverse(js)
        case LCons(h, t)             =>
            let tail = force t;
            if (i % h == 0) primeFactorsRec(i / h, j, h :: js)
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
        import java.lang.Math:pow(Float64, Float64);
        let p = pow(Int32.toFloat64(l), Int32.toFloat64(r)) as & Pure;
        Float64.tryToInt32(p)

    pub def phi(i: Int32): Option[Int32] =
        primeFactorMultiplicity(i) |> List.foldLeft(((accOpt, x) ->
            let (l, r) = x;
            powInt(l, r - 1) |> Option.map2((acc, u) -> (l - 1) * u * acc, accOpt)
        ), Some(1))

    pub def primesInRange(l: Int32, r: Int32): List[Int32] =
        primes() |>
        LazyLists.filter(x -> x >= l ) |>
        LazyLists.takeWhile(x -> x <= r) |>
        LazyList.toList

    pub def goldbach(i: Int32): Option[(Int32, Int32)] =
        primes() |>
        LazyLists.filter(x -> x < i) |>
        LazyLists.find(x -> isPrime(i - x) and x != (i - x)) |>
        Option.map(p1 -> (p1, i - p1))
}
