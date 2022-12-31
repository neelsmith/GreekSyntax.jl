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

	# 5-8
	node1 = parts[5] == "nothing" ? nothing : parts[5]
	node1rel = parts[6] == "nothing" ? nothing : parts[6]
	node2 = parts[7] == "nothing" ? nothing : parts[7]
	node2rel = parts[8] == "nothing" ? nothing : parts[8]
	TokenAnnotation(CtsUrn(parts[1]),
		parts[2],
		parts[3],
		parts[4],
		node1,
		node1rel,
		node2,
		node2rel
	)
end