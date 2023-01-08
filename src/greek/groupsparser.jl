"""Parse delimited string `s` into a `VerbalUnitAnnotation`.
$(SIGNATURES)
"""
function verbalunit(s, ortho::LiteraryGreekOrthography; delimiter = "|")
	parts = split(s, delimiter)
	VerbalUnitAnnotation(parts[1],
		parts[2],
		parts[3],
		parse(Int, parts[4]),
		CtsUrn(parts[5])
	)
end

"""Parse delimited string `s` into a `VerbalUnitAnnotation`.
$(SIGNATURES)
"""
function verbalunit(s; delimiter = "|")
	verbalunit(s, literaryGreek(), delimiter = delimiter)
end