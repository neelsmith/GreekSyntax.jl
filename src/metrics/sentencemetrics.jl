

"""Find maximum depth of subordination in sentence `s`.
$(SIGNATURES)
"""
function maxdepth(s::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation})
	sentgroups = groupsforsentence(s, groups)
	map(gr -> gr.depth, sentgroups) |> maximum
end

"""Find maximum distance between syntactically related tokens.
$(SIGNATURES)
"""
function maxtokendistance()
end

"""Find average distance between syntactically related tokens.
$(SIGNATURES)
"""
function avgtokendistance()
end

"""Find maximum displacement between syntactically related tokens.
$(SIGNATURES)
"""
function maxtokendisplacement()
end

"""Find average displacement between syntactically related tokens.
$(SIGNATURES)
"""
function avgtokendisplacement()
end

"""Find maximum displacement between verbal expressions.
$(SIGNATURES)
"""
function maxgroupdisplacement()
end

"""Find average displacement between verbal expressions.
$(SIGNATURES)
"""
function avggroupdisplacement()
end
