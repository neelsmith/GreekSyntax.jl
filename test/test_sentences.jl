@testset "Test parsing a text corpus into sentences" begin
    srcf = joinpath(pwd(), "data", "lysias1.cex")
    c = fromcex(srcf, CitableTextCorpus, FileReader)
    sentenceidx = parsesentences(c, literaryGreek())
    @test length(sentenceidx) == 123
end


@testset "Test serializing sentences" begin
    range = CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.9.29-1.9.38a")
    seq = 1
    connector = CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.9.30")
    s = SentenceAnnotation(range, seq, connector)

    expected = "urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.9.29-1.9.38a|1|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.9.30"
    @test delimited(s) == expected
end

@testset "Test finding range of sentence in tokens" begin
    corp = fromcex(joinpath(pwd(), "data", "lysias1.cex"), CitableTextCorpus, FileReader)
    
end