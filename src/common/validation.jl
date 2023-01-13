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

verbsemantics = [
    "transitive", 
    "intransitive", 
    "linking"
]

"Authority list for syntactic relation between tokens."
syntaxrelations = [
    "unit verb",
    "object",
    "predicate",
    "subject",
    "direct address",
    "complementary infintive",
    "supplementary participle",
    "modal particle",
    "adverbial",

    "object of preposition",

    "attributive",
    "article",
    "pronoun"
]

syntaxdict = Dict(
    "op" => "object of preposition",
    "o" => "object",
    "s" => "subject"
)



"""Returns a validated string for `s` from the authority list `authlist`.  A string is considered valid if:

1. its lowercase value appears as a key value in a dictionary of abbreviations
2. its lowercase value is a unique starting value for an item in the authority list
3. its lowercase value matches an item in the authority list within a specified threshhold for Levenshtein edit distance

$(SIGNATURES)
"""
function validatedform(s::T, authlist::Vector{String}; abbrdict = Dict(), threshhold = 1.0 ) where T <: AbstractString
    lc = lowercase(s)
    initialmatches = filter(str -> startswith(str, lc), authlist)
    if lc in keys(abbrdict)
        abbrdict[lc]
    elseif length(initialmatches) == 1  
        initialmatches[1]
    else
        editscores = map(str -> (dataval = str, score = compare(str, lc, Levenshtein())), authlist)
        passingscores = filter(pr -> pr[:score] >= threshhold, editscores)    
        length(passingscores) == 1 ? passingscores[1][:dataval] : nothing        
    end
end


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