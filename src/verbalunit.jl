struct VerbalUnitAnnotation
	id
	semantic_type
	syntactic_type
	depth::Int
end


"""Parse delimited string `s` into a `VerbalUnitAnnotation`."""
function verbalunit(s; delimiter = "|")
	parts = split(s, delimiter)
	VerbalUnitAnnotation(parts[1],
		parts[2],
		parts[3],
		parse(Int, parts[4])
	)
end

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