

"""Find maximum depth of subordination in sentence `s`.
$(SIGNATURES)
"""
function maxdepth(s::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation})
	sentgroups = groupsforsentence(s, groups)
	map(gr -> gr.depth, sentgroups) |> maximum
end


#=
## Sentences

- maxdepth: maximum syntactic level of a sentence
- maxtokendistance
- avgtokendistance
- maxgroupdistance
- avggroupdistance
=#