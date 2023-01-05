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

@testset "Test finding range of sentence in orthographic tokens" begin
    corp = fromcex(joinpath(pwd(), "data", "lysias1.cex"), CitableTextCorpus, FileReader)
    orthotokens = tokenize(corp, literaryGreek())
    expectedrange = CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.1.1-1.2.28")
    @test GreekSyntax.sentencerange(orthotokens[1:100]) == expectedrange
end

@testset "Test finding range of sentence in annotated tokens" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)
    expectedrange = CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.7.17")
    @test GreekSyntax.sentencerange(tokens[1:100]) == expectedrange
end