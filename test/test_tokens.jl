@testset "Testing finding verbal expression for a token" begin
    datalines = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sentences, groups, tokens) = readdelimited(datalines)

    expected = VerbalUnitAnnotation("1.6.1-1.6.46a.1", "intransitive", "independent clause", 1, CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.46a"))
    @test GreekSyntax.groupfortoken(tokens[1], groups) == expected

end