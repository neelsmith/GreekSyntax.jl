@testset "Testing finding verbal expression for a token" begin
    datalines = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sentences, groups, tokens) = readdelimited(datalines)

    expected = VerbalUnitAnnotation("1.6.1-1.6.46a.1", "intransitive", "Independent clause", 1, CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.46a"))


    @test GreekSyntax.groupfortoken(tokens[1], groups) == expected

end

@testset "Test finding syntactic depth of a token" begin
    datalines = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sentences, groups, tokens) = readdelimited(datalines)

    @test GreekSyntax.depthfortoken(tokens[1], groups) == 1
end

@testset "Test deriving a `CitablePassage` from a token annotation" begin
    datalines = joinpath(pwd(), "data", "Lysias1.6ff.cex")   |> readlines
    (sentences, groups, tokens) = readdelimited(datalines)
    
    expected = CitablePassage(CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1"), "ἐγὼ")
    @test GreekSyntax.passagefromtoken(tokens[1]) == expected
end


@testset "Test filtering tokens by their depth of subordination" begin
    datalines = joinpath(pwd(), "data", "Lysias1.6ff.cex")   |> readlines
    (sentences, groups, tokens) = readdelimited(datalines)

    (senttokens,connectors,origin) = GreekSyntax.tokeninfoforsentence(sentences[1], tokens)

    @test length(GreekSyntax.filterbylevel(1, groups, senttokens)) == 15
    @test length(GreekSyntax.filterbylevel(2, groups, senttokens)) == 45

end