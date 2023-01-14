@testset "Test validation of arbitrary string values" begin

    authlist = ["subject", "object", "predicate", "unit verb", "object of preposition"]
    @test validatedform("subject", authlist) == "subject"
    @test validatedform("Object of Preposition", authlist) == "object of preposition"
    
    @test validatedform("Subjective", authlist) |> isnothing

    abbrs = Dict(
        "o" => "object",
        "op" => "object of preposition"
    )
    @test validatedform("op", authlist, abbrdict = abbrs) == "object of preposition"
    @test validatedform("o", authlist, abbrdict = abbrs) == "object"
    @test validatedform("s", authlist, abbrdict = abbrs) == "subject"


    @test validatedform("objcet of preposition", authlist) |> isnothing
    @test validatedform("objcet of preposition", authlist, threshhold = 0.9) == "object of preposition"
    @test validatedform("subjcet", authlist, threshhold = 0.9) |> isnothing
    @test validatedform("subjcet", authlist, threshhold = 0.7) == "subject"

end

@testset "Test exception handling in validation" begin
    badgroup = "1.24.1-1.24.11a.1|Independent clause|ADD VALUE HERE|1|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.24.1-1.24.11a"    
    @test_throws DomainError verbalunit(badgroup)
    badvalallowed = verbalunit(badgroup, strict = false)
    @test badvalallowed isa VerbalUnitAnnotation



    badrel1  = "urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.7.29|lexical|γεγένηται|1.7.17-1.7.29a.2|2|NOT A VALUE|nothing|nothing"
    @test_throws DomainError token(badrel1)
    @test token(badrel1, strict = false) isa TokenAnnotation

    badrel2  = "urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.7.29|lexical|γεγένηται|1.7.17-1.7.29a.2|2|unit verb|3|NOT A VALUE"
    @test_throws DomainError token(badrel2)
    @test token(badrel2, strict = false) isa TokenAnnotation
end


@testset "Test validation for authority list for syntactic type of verbal expression" begin
    @test GreekSyntax.validatedvutype("attributive participle") == "attributive participle"
    @test GreekSyntax.validatedvutype("at") == "attributive participle"
    @test GreekSyntax.validatedvutype("as") == "aside"
    @test GreekSyntax.validatedvutype("a") |> isnothing
end

@testset "Test validation for authority list for semantic type of verbal expression" begin
    @test GreekSyntax.validatedverbsemantics("t") == "transitive"
    @test GreekSyntax.validatedverbsemantics("T") == "transitive"
    @test GreekSyntax.validatedverbsemantics("in") == "intransitive"
    @test GreekSyntax.validatedverbsemantics("l") == "linking"

    @test GreekSyntax.validatedverbsemantics("trasnitive") |> isnothing
    @test GreekSyntax.validatedverbsemantics("trasnitive", threshhold = 0.8) == "transitive"
end


@testset "Test validation for authority list for syntactic relations of tokens" begin
    @test GreekSyntax.validatedrelation("u") == "unit verb"
    @test GreekSyntax.validatedrelation("sub") |> isnothing
    @test GreekSyntax.validatedrelation("sup") == "supplementary participle"
    @test GreekSyntax.validatedrelation("subj") == "subject"
    @test GreekSyntax.validatedrelation("subo") == "subordinate conjunction"
    # Built-in dictionary of abbreviations!
    @test GreekSyntax.validatedrelation("s") == "subject"
    @test GreekSyntax.validatedrelation("sc") == "subordinate conjunction"

end