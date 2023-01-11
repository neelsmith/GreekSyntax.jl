

"""Find maximum depth of subordination in sentence `s`.
$(SIGNATURES)
"""
function maxdepth(s::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation})
	sentgroups = groupsforsentence(s, groups)
	map(gr -> gr.depth, sentgroups) |> maximum
end

"""Find maximum distance between syntactically related tokens
in a single sentence.
$(SIGNATURES)
"""
function maxtokendistance(s::SentenceAnnotation, tknlist::Vector{TokenAnnotation})::Int
	lex = lexicalforsentence(s, tknlist)
	max = 0
	for t in lex
		dist = distance(t, s, tknlist)
		if isnothing(dist)

		elseif dist > max
			max = dist
		end
	end
	max
end

"""Find average distance between syntactically related tokens.
$(SIGNATURES)
"""
function avgtokendistance(s::SentenceAnnotation, tknlist::Vector{TokenAnnotation})
	lex = lexicalforsentence(s, tknlist)
	scores = map(tknlist) do tkn
		distance(tkn, s, lex)
	end
	nonnull = filter(score -> !isnothing(score), scores)
	sum(nonnull) / length(nonull)

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
