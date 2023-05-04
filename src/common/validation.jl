
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




"""Map strings in list `vocab` to strings with markdown hilighting
of short cut (ie, minimum unique initial string)
$(SIGNATURES)
"""
function mdshortcuts(vocab)
    results = []
    for s in vocab
        min = length(s)
        for i in length(s):-1:1
            substr = s[1:i]
            matches = filter(code -> startswith(code, substr), vocab)
            #@info("Matches for $(substr):  $(matches) ($(length(matches)))")
            if length(matches) == 1 && i < min
                min = i
            end
        end
        hilited = min < length(s) ? string("**", s[1:min], "**", s[min+1:end]) : string("**", s, "**")

        push!(results, (hilited))
    end
    results
end