
@testset "Test reading syntax annotations from a delimited-text file" begin
    src = joinpath(pwd(), "data", "lysias1_selection.cex") |> readlines
    (sents, vus, tkns) = readdelimited(src)
    
    @test length(sents) == 2
    @test length(vus) == 7
    @test length(tkns) == 36
    
end


@testset "Test reading and writing annotations" begin
    vudelim = "1.8.1-1.8.15a.1|independent clause|transitive|1|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.1-1.8.15a"
    @test delimited(GreekSyntax.verbalunit(vudelim )) == vudelim
end
