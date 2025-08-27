mod Logics.P49 {

    def gray(n: Int32): List[String] =
        if (n == 0) "" :: Nil
        else
            let lower = gray(n - 1);
            (lower |> List.map( x -> "0" + x )) ::: (lower |> List.reverse |> List.map(x -> "1" + x ))

    @test
    def testgray01(): Bool =
        gray(1) == "0" :: "1" :: Nil

    @test
    def testgray02(): Bool =
        gray(2) == "00" :: "01" :: "11" :: "10" :: Nil

    @test
    def testgray03(): Bool =
        gray(3) == "000" :: "001" :: "011" :: "010" :: "110" :: "111" :: "101" :: "100" :: Nil
}
