@testset "Test parsing a text corpus into sentences" begin
    srcf = joinpath(pwd(), "data", "lysias1.cex")
    c = fromcex(srcf, CitableTextCorpus, FileReader)
    (urns, tkns) = GreekSyntax.tokensbysentence(c)
    @test length(urns) == 121
    @test length(tkns) == length(urns)
    
end