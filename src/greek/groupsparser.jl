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