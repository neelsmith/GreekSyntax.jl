struct VerbalUnitAnnotation
	id
	syntactic_type
	semantic_type
	depth::Int
	sentence::CtsUrn
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


"""Parse delimited string `s` into a `VerbalUnitAnnotation`."""
function verbalunit(s; delimiter = "|")
	parts = split(s, delimiter)
	VerbalUnitAnnotation(parts[1],
		parts[2],
		parts[3],
		parse(Int, parts[4]),
		CtsUrn(parts[5])
	)
end

