
@testset "Test reading syntax annotations from a delimited-text file" begin
    src = joinpath(pwd(), "data", "lysias1_selection.cex") |> readlines
    (sents, vus, tkns) = readdelimited(src)
    
    @test length(sents) == 2
    @test length(vus) == 7
    @test length(tkns) == 36
    
end
