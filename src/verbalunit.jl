struct VerbalUnitAnnotation
	id
	semantic_type
	syntactic_type
	depth::Int
	sentence::CtsUrn
end

"""Compose delimited-text representation of a `VerbalUnitAnnotation`.
$(SIGNATURES)
"""
function delimited(vu::VerbalUnitAnnotation; delimiter = "|")
	string(vu.id,delimiter,vu.semantic_type,delimiter, vu.depth, delimiter, vu.sentence)
end


"""Compose delimited-text representation of a Vector of `VerbalUnitAnnotation`s.
$(SIGNATURES)
"""
function delimited(vulist::Vector{VerbalUnitAnnotation}; delimiter = "|")
	hdr = "vuid$(delimiter)semantic_type$(delimiter)syntactic_type$(delimiter)depth$(delimiter)sentence\n"
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


#=
"""Parse delimited string `s` into a `TokenAnnotation`."""
function token(s; delimiter = "|")
	parts = split(s, delimiter)
	TokenAnnotation(CtsUrn(parts[1]),
		parts[2],
		parts[3],
		parts[4],
		parts[5],
		parts[6],
		parts[7],
		parts[8]
	)
end
=#