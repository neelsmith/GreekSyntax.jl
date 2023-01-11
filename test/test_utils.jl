@testset "Test selecting data for a sentence" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)
    s1 = sents[1]

    tokenlist = tokensforsentence(s1, tokens)
    connectorlist = GreekSyntax.connectorindexes(s1, tokens)
    origin = GreekSyntax.originindex(s1, tokens)

    @test length(tokenlist) == 52
    @test connectorlist == 2:2
    @test origin == 1

    @test GreekSyntax.sentencerange(tokenlist) == s1.range

    grps = GreekSyntax.groupsforsentence(s1, groups)
    # Test this...
end

@testset "Test filtering tokens by syntactic level" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)
    s1 = sents[1]

    # Add test on filtering by syntactic level
   @test_broken 1 == 2

 
end