"""
range of tokens
$(SIGNATURES)
"""
function span(grp::VerbalUnitAnnotation, s::SentenceAnnotation, tokens::Vector{TokenAnnotation})
    senttokens = lexicalforsentence(s, tokens)
    grouptokens = tokensforgroup(grp, senttokens)
    firstidx = findfirst(t -> t == grouptokens[1], senttokens)
    lastidx = findfirst(t -> t == grouptokens[end], senttokens)
    (firstidx,lastidx)
end

"""
range of tokens
$(SIGNATURES)
"""
function span(grp::VerbalUnitAnnotation, sentences::Vector{SentenceAnnotation}, tokens::Vector{TokenAnnotation})
    s = sentenceforgroup(grp, sentences)
    span(grp, s, tokens)    
end

"""
distance from first to last token in group
$(SIGNATURES)
"""
function spansize(grp::VerbalUnitAnnotation, s::SentenceAnnotation, tokens::Vector{TokenAnnotation})
    grouprange = span(grp, s, tokens)
    grouprange[2] - grouprange[1] + 1
end

"""
distance from first to last token in group
$(SIGNATURES)
"""
function spansize(grp::VerbalUnitAnnotation, sentences::Vector{SentenceAnnotation}, tokens::Vector{TokenAnnotation})
    s = sentenceforgroup(grp, sentences)
    spansize(grp, s, tokens)
end

"""number of groups between start and end of span 
$(SIGNATURES)
"""
function displacedby(grp::VerbalUnitAnnotation, s::SentenceAnnotation, tokens::Vector{TokenAnnotation})
    (startidx, endidx) = span(grp, s, tokens)
    senttokens = lexicalforsentence(s, tokens)

    othergroups = []
    for t in senttokens[startidx:endidx]
        if isnothing(t.verbalunit) || t.verbalunit == "nothing"
            # omit
        elseif t.verbalunit != grp.id
            push!(othergroups, t.verbalunit)
        end
    end
    unique(othergroups) 
end

function displacement(grp::VerbalUnitAnnotation, s::SentenceAnnotation, tokens::Vector{TokenAnnotation})
    displacedby(grp, s, tokens) |> length
end

function displacement(grp::VerbalUnitAnnotation, sentences::Vector{SentenceAnnotation}, tokens::Vector{TokenAnnotation})
    s = sentenceforgroup(grp, sentences) 
    displacement(grp, s, tokens)
end

"""number of groups between start and end of span 
$(SIGNATURES)
"""
function displacedby(grp::VerbalUnitAnnotation, sentences::Vector{SentenceAnnotation}, tokens::Vector{TokenAnnotation})
    s = sentenceforgroup(grp, sentences)
    displacedby(grp, s, tokens)
end


"""
- cohesion: proportion of tokens with span belonging to group 
$(SIGNATURES)
"""
function cohesion()
end