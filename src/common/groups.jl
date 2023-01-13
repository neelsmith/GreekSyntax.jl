"""Annotations on a verbal expression."""
struct VerbalUnitAnnotation
	id
	syntactic_type
	semantic_type
	depth::Int
	sentence::CtsUrn
end

"""Implement equality testing on `VerbalUnitAnnotation`s.
$(SIGNATURES)
"""
function ==(vu1::VerbalUnitAnnotation, vu2::VerbalUnitAnnotation)

	lc1syntype = isnothing(vu1.syntactic_type) ? "" : lowercase(vu1.syntactic_type)
	lc2syntype = isnothing(vu2.syntactic_type) ? "" : lowercase(vu2.syntactic_type)

	lc1semtype = isnothing(vu1.semantic_type) ? "" : lowercase(vu1.semantic_type)
	lc2semtype = isnothing(vu2.semantic_type) ? "" : lowercase(vu2.semantic_type)


	vu1.id == vu2.id &&
	lc1syntype == lc2syntype &&
	lc1semtype == lc2semtype &&
	vu1.depth == vu2.depth &&
	vu1.sentence == vu2.sentence
end

"""Compose delimited-text representation of a `VerbalUnitAnnotation`.
$(SIGNATURES)
"""
function delimited(vu::VerbalUnitAnnotation; delimiter = "|")
	string(vu.id,delimiter,vu.syntactic_type,delimiter,vu.semantic_type,delimiter, vu.depth, delimiter, vu.sentence)
end


"""Compose delimited-text representation of a Vector of `VerbalUnitAnnotation`s.
$(SIGNATURES)
"""
function delimited(vulist::Vector{VerbalUnitAnnotation}; delimiter = "|")
	hdr = "vuid$(delimiter)syntactic_type$(delimiter)semantic_type$(delimiter)depth$(delimiter)sentence\n"
	hdr * join(map(vu -> delimited(vu), vulist), "\n") * "\n"
end




