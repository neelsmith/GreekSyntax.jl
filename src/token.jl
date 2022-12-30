struct TokenAnnotation
	urn::CtsUrn
	tokentype
	text
	verbalunit
	node1
	node1relation
	node2
	node2relation
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