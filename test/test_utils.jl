@testset "Test selecting data for a sentence" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)
    s1 = sents[1]

    (tokenlist, connectorlist, origin)  = GreekSyntax.tokeninfoforsentence(s1, tokens)
    @test length(tokenlist) == 52
    @test connectorlist == 2:2
    @test origin == 1

    @test GreekSyntax.sentencerange(tokenlist) == s1.range


    grps = GreekSyntax.groupsforsentence(s1, groups)
end

@testset "Test filtering tokens by syntactic level" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)
    s1 = sents[1]

    (tokenlist, connectorlist, origin)  = GreekSyntax.tokeninfoforsentence(s1, tokens)

 
end