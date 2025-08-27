mod Arithmetics.P38 {
    use Arithmetics.{totient, totientPrimeFactor};
    //@benchmark
    pub def benchmarkTotient(): Bool =
        totient(10) == 4

    //@benchmark
    pub def benchmarkTotientPrimeFactor(): Bool =
        totientPrimeFactor(10) == Some(4)
}
