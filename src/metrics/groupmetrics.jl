"""
Find indexes within lexical tokens of sentence `s` the first and last token belonging to group `grp`.
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
Find indexes within lexical tokens of the sentence `grp` belongs to of the first and last tokens of group `grp`.
$(SIGNATURES)
"""
function span(grp::VerbalUnitAnnotation, sentences::Vector{SentenceAnnotation}, tokens::Vector{TokenAnnotation})
    s = sentenceforgroup(grp, sentences)
    span(grp, s, tokens)    
end

"""
Find the number of tokens included in the span of `grp`.
$(SIGNATURES)
"""
function spansize(grp::VerbalUnitAnnotation, s::SentenceAnnotation, tokens::Vector{TokenAnnotation})
    grouprange = span(grp, s, tokens)
    grouprange[2] - grouprange[1] + 1
end

"""
Find the number of tokens included in the span of `grp`.
$(SIGNATURES)
"""
function spansize(grp::VerbalUnitAnnotation, sentences::Vector{SentenceAnnotation}, tokens::Vector{TokenAnnotation})
    s = sentenceforgroup(grp, sentences)
    spansize(grp, s, tokens)
end

"""
List other groups appearing between first and last tokens
belonging to group `grp`.
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

"""
List other groups appearing between first and last tokens
belonging to group `grp`.
$(SIGNATURES)
"""
function displacedby(grp::VerbalUnitAnnotation, sentences::Vector{SentenceAnnotation}, tokens::Vector{TokenAnnotation})
    s = sentenceforgroup(grp, sentences)
    displacedby(grp, s, tokens)
end

"""Find number of other groups occurring within span of `grp`.
$(SIGNATURES)
"""
function displacement(grp::VerbalUnitAnnotation, s::SentenceAnnotation, tokens::Vector{TokenAnnotation})
    displacedby(grp, s, tokens) |> length
end

"""Find number of other groups occurring within span of `grp`.
$(SIGNATURES)
"""
function displacement(grp::VerbalUnitAnnotation, sentences::Vector{SentenceAnnotation}, tokens::Vector{TokenAnnotation})
    s = sentenceforgroup(grp, sentences) 
    displacement(grp, s, tokens)
end



"""Compute the proportion of tokens within the  span of `grp` that  belonging to the group.
$(SIGNATURES)
"""
function cohesion(grp::VerbalUnitAnnotation, sentences::Vector{SentenceAnnotation}, tokens::Vector{TokenAnnotation})
    s = sentenceforgroup(grp, sentences) 
    cohesion(grp, s, tokens)
end



"""Compute the proportion of tokens within the  span of `grp` that  belonging to the group.
$(SIGNATURES)
"""
function cohesion(grp::VerbalUnitAnnotation, s::SentenceAnnotation, tokens::Vector{TokenAnnotation})
    (startidx, endidx) = span(grp, s, tokens)
    senttokens = lexicalforsentence(s, tokens)

    seen = 0
    others = 0
    for t in senttokens[startidx:endidx]
        if isnothing(t.verbalunit) || t.verbalunit == "nothing"
            # omit
        else
            seen = seen + 1
            if t.verbalunit != grp.id
                others = others + 1
            end
        end
    end
    (seen - others) / seen    
end