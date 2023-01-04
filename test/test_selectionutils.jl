
@testset "Test selecting related items" begin
    datalines = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sentences, groups, tokens) = readdelimited(datalines)

    tkn1 = GreekSyntax.token("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.2|lexical|γάρ|1.6.1-1.6.46a.1|nothing|nothing|nothing|nothing")
    
    group1 = VerbalUnitAnnotation("1.6.1-1.6.46a.1", "intransitive", "independent clause", 1, CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.4"))
    group = GreekSyntax.groupfortoken(tkn1, groups) 
    @test group.id == group1.id


    tknmatches = GreekSyntax.tokensforgroup(group1, tokens) 
    @test length(tknmatches) == 52



end