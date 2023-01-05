
"""Compose a string value for type of token, for use in
writing delimited-text representation of annotations.
"""
function typelabel(tkntype)
	if string(typeof(tkntype)) == "Orthography.LexicalToken"
		"lexical"
	elseif string(typeof(tkntype)) == "Orthography.PunctuationToken"
		"punctuation"
	elseif string(typeof(tkntype)) == "Orthography.UnanalyzedToken"
		"unanalyzed"
	else
		"unrecognized"
	end
end



"""Map a `TokenAnnotation` to a `CitablePassage` cited
at the token level.
$(SIGNATURES)
"""
function passagefromtoken(tkn::TokenAnnotation)::CitablePassage
	CitablePassage(tkn.urn, string(tkn.text))
end


"""Find all tokens at level of subordination <= `depth`.
$(SIGNATURES)
"""
function filterbylevel(depth::Int, groups::Vector{VerbalUnitAnnotation}, tokens::Vector{TokenAnnotation})
	filter(tokens) do tkn
	    grp = groupfortoken(tkn, groups)
	    !isnothing(grp) && grp.depth <= threshhold && grp.depth != 0
	end
end