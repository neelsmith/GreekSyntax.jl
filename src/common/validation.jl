
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


