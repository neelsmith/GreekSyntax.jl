
"""Find all tokens belonging to a given verbal unit.
$(SIGNATURES)
"""
function tokensforgroup(group::VerbalUnitAnnotation, tokens::Vector{TokenAnnotation})
	filter(tokens) do t
		t.verbalunit == group.id
	end
end


"""Find sentence that `group` belongs to.
$(SIGNATURES)
"""
function sentenceforgroup(group::VerbalUnitAnnotation, sentences::Vector{SentenceAnnotation})::Union{SentenceAnnotation, Nothing}
	matches = filter(s -> s.range == group.sentence, sentences)
	if length(matches) == 1
		matches[1]
	elseif isempty(matches)
		@warn("No sentence matched $(group.sentence)")
		nothing
	else
		@warn("Multiple sentences matches $(group.sentence). Cowardly returning nothing.")
		nothing
	end
end