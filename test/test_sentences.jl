@testset "Test parsing a text corpus into sentences" begin
    srcf = joinpath(pwd(), "data", "texts", "lysias1.cex")
    c = fromcex(srcf, CitableTextCorpus, FileReader)
    sentenceidx = parsesentences(c, literaryGreek())
    @test length(sentenceidx) == 128
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
    src = joinpath(pwd(), "data", "texts", "lysias1.cex")
    corp = fromcex(src, CitableTextCorpus, FileReader)
    orthotokens = tokenize(corp, literaryGreek())
    expectedrange = CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.1.1-1.2.10")
    @test GreekSyntax.sentencerange(orthotokens[1:80]) == expectedrange
end

@testset "Test finding range of sentence in annotated tokens" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)
    expectedrange = CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.70a")
    @test GreekSyntax.sentencerange(tokens[1:80]) == expectedrange
end

@testset "Test finding token information for a sentence" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)

    (senttokens,connectors,origin) = GreekSyntax.tokeninfoforsentence(sents[1], tokens)

    @test origin == 1
    @test connectors == 2:2
    @test length(senttokens) == 52
end

@testset "Test finding verbal expressions for a sentence" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)
    @test length(GreekSyntax.groupsforsentence(sents[1], groups)) == 10
end

@testset "Test identifying from a list of sentences the sentence including a URN" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)
    
    @test GreekSyntax.sentenceindexfornode(tokens[55].urn, sents, tokens) == 2
    @test GreekSyntax.sentencesforurn(tokens[55].urn, sents, tokens)[1] == sents[2]
end


@testset "Test finding maximum syntactic depth for a sentence" begin
    data = joinpath(pwd(), "data", "Lysias1.6ff.cex") |> readlines
    (sents, groups, tokens) = readdelimited(data)
   @test GreekSyntax.maxdepthforsentence(sents[1], groups)  == 3
end