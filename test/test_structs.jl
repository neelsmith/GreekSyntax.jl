@testset "Test == function on all structs" begin
    datalines = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sentences, groups, tokens) = readdelimited(datalines)
   
    
    s1 = SentenceAnnotation(CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.46a"), 10, CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.2"))
    @test s1 == sentences[1]


    g1 = VerbalUnitAnnotation("1.6.1-1.6.46a.1", "intransitive", "independent clause", 1, CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.46a"))
    @test g1 == groups[1]


    t1 = TokenAnnotation(CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1"), "lexical", "ἐγὼ", "1.6.1-1.6.46a.1", 20, "subject", nothing, nothing)
    @test t1 == tokens[1]
end