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