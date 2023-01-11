

function distance(tkn::TokenAnnotation, tknlist::Vector{TokenAnnotation})
    tkn1.node1

end

function displacement()
end

function cohesion()
end


"""Find maximum depth of subordination in sentnec `s`.
$(SIGNATURES)
"""
function maxdepth(s::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation})
	sentgroups = groupsforsentence(s, groups)
	map(gr -> gr.depth, sentgroups) |> maximum
end