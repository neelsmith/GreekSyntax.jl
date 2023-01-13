"Authority list for type of verbal expression"
vutypes = [
    "independent clause",
    "subordinate clause",
    "circumstantial participle",
    "attributive participle",
    "infinitive in indirect statement",
    "participle in indirect statement",
    "quote",
    "aside"
]

"Authority list for sematnic type of verbs."
verbsemantics = [
    "transitive", 
    "intransitive", 
    "linking"
]

"Authority list for syntactic relation between tokens."
syntaxrelations = [
    "conjunction",
    "subordinate conjunction",
    "relative pronoun",

    "unit verb",

    "object",
    "predicate",
    "subject",
    "direct address",
    "complementary infinitive",
    "supplementary participle",
    "modal particle",
    "adverbial",

    "object of preposition",

    "attributive",
    "article",
    "pronoun",

    "dative",
    "genitive"
]

"Abbreviation dictionary for syntactic relations"
syntaxdict = Dict(
    "op" => "object of preposition",
    "sc" => "subordinate conjunction",
    "o" => "object",
    "s" => "subject"
)


"""Return a validated string value for the syntactic type of a verbal expression, or `nothing`
if `s` fails to satisfy matching criteria.
$(SIGNATURES)
"""
function validatedvutype(s::T; threshhold = 1.0) where T <: AbstractString
    validatedform(s, vutypes, threshhold =  threshhold)
end


"""Return a validated string value for the semantics of a verbal expression, or `nothing`
if `s` fails to satisfy matching criteria.
$(SIGNATURES)
"""
function validatedverbsemantics(s::T; threshhold = 1.0) where T <: AbstractString
    validatedform(s, verbsemantics, threshhold =  threshhold)
end

"""Return a validated string value for syntactic relation between two tokens, or `nothing`
if `s` fails to satisfy matching criteria.
$(SIGNATURES)
"""
function validatedrelation(s::T; threshhold = 1.0) where T <: AbstractString
    validatedform(s, syntaxrelations, abbrdict = syntaxdict,  threshhold =  threshhold)
end
