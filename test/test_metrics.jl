@testset "Test token metrics" begin

end

@testset "Test sentence metrics" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)
    @test length(GreekSyntax.tokensforgroup(groups[1], tokens)) == 9
end


@testset "Test finding maximum syntactic depth for a sentence" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)
   @test GreekSyntax.maxdepth(sents[1], groups)  == 3
end