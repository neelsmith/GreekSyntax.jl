

"""Find maximum depth of subordination in sentence `s`.
$(SIGNATURES)
"""
function maxdepth(s::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation})
	sentgroups = groupsforsentence(s, groups)
	map(gr -> gr.depth, sentgroups) |> maximum
end


function maxtokendistance()
end
function avgtokendistance()
end
function maxgroupdistance()
end
function avggroupdistance()
end
