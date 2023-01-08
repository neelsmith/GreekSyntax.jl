
@testset "Test reading syntax annotations from a delimited-text file" begin
    src = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, vus, tkns) = readdelimited(src)
    
    @test length(sents) > 2
    @test length(vus) > 15
    @test length(tkns) > 80
    
end


@testset "Test reading and writing annotations" begin
    sentdelim = "urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.1-1.8.15a|15|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.3"
    @test  delimited(sentence(sentdelim)) == sentdelim

    vudelim = "1.8.1-1.8.15a.1|independent clause|transitive|1|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.1-1.8.15a"
    @test delimited(verbalunit(vudelim )) == vudelim

    tkndelim  = "urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.7.29|lexical|γεγένηται|1.7.17-1.7.29a.2|2|unit verb|nothing|nothing"
    @test delimited(token(tkndelim)) == tkndelim

    
    implieddelim  = "nothing|implied|implied|1.7.17-1.7.29a.2|100|unit verb|nothing|nothing"
    @test delimited(token(implieddelim)) == implieddelim
 
end


