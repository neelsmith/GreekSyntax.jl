"""
range of tokens
$(SIGNATURES)
"""
function span(grp::VerbalUnitAnnotation, s::SentenceAnnotation, tokens::Vector{TokenAnnotation})
    
end

"""
distance from first to last token in group
$(SIGNATURES)
"""
function spansize()
end


"""number of groups between start and end of span 
$(SIGNATURES)
"""
function displacement()
end


"""
- cohesion: proportion of tokens with span belonging to group 
$(SIGNATURES)
"""
function cohesion()
end