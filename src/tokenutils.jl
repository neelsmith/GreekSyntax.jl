
s"""Find the `VerbalUnitAnnotation` object for a given token.
$(SIGNATURES)
"""
function groupfortoken(tkn::TokenAnnotation, groups::Vector{VerbalUnitAnnotation})
	groupmatches = filter(g -> g.id == tkn.verbalunit, groups)
	if length(groupmatches) ==  1
		groupmatches[1]
	elseif length(groupmatches) > 1
		@warn("Multiple matches found for token $(tkn.urn) with verbal unit $(tkn.verbalunit)! ")
		nothing
	else
		@debug("No group found for token $(tkn.urn) with verbal unit $(tkn.verbalunit) ")
		nothing
	end
end

"""Find syntactic depth of token `tkn`.
$(SIGNATURES)
"""
function depthfortoken(tkn::TokenAnnotation, groups::Vector{VerbalUnitAnnotation})
	grp = groupfortoken(tkn, groups)
	isnothing(grp) ? nothing : grp.depth
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
	    !isnothing(grp) && grp.depth <= depth && grp.depth != 0
	end
end