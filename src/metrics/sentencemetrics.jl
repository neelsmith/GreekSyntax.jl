

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
	scores = []
	for t in lex
		dist = distance(t, s, tknlist)
		if isnothing(dist)

		else
			push!(scores, dist)
		end
	end
	sum(scores) / length(scores)
end

"""Find maximum displacement between syntactically related tokens.
$(SIGNATURES)
"""
function maxtokendisplacement(s::SentenceAnnotation, tknlist::Vector{TokenAnnotation})
	maxtokendistance(s, tknlist) - 1
end

"""Find average displacement between syntactically related tokens.
$(SIGNATURES)
"""
function avgtokendisplacement(s::SentenceAnnotation, tknlist::Vector{TokenAnnotation})
	lex = lexicalforsentence(s, tknlist)
	scores = []
	for t in lex
		disp = displacement(t, s, tknlist)
		if isnothing(disp)

		else
			push!(scores, disp)
		end
	end
	sum(scores) / length(scores)
end




"""Find maximum displacement between verbal expressions.
$(SIGNATURES)
"""
function maxgroupdisplacement(s::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation}, tokens::Vector{TokenAnnotation})
	max = 0
	for g in groupsforsentence(s, groups)
		disp = displacement(g, s, tokens)
		if isnothing(disp)

		elseif disp > max
			max = disp
		end
	end
	max
end

"""Find average displacement between verbal expressions.
$(SIGNATURES)
"""
function avggroupdisplacement(s::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation}, tokens::Vector{TokenAnnotation})
	scores = []
	for g in groupsforsentence(s, groups)
		disp = displacement(g, s, tokens)
		if isnothing(disp)

		else
			push!(scores, disp)
		end
	end
	sum(scores) / length(scores)
end
