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


"""Implement equality testing on `TokenAnnotation`s.
$(SIGNATURES)
"""
function ==(t1::TokenAnnotation, t2::TokenAnnotation)
	lc1rel1 = isnothing(t1.node1relation) ? "" : lowercase(t1.node1relation)
	lc1rel2 = isnothing(t1.node2relation) ? "" : lowercase(t1.node1relation)

	lc2rel1 = isnothing(t2.node1relation) ? "" : lowercase(t2.node1relation)
	lc2rel2 = isnothing(t2.node2relation) ? "" : lowercase(t2.node1relation)

	t1.urn == t2.urn &&
	lowercase(t1.tokentype) == lowercase(t2.tokentype) &&
	t1.text == t2.text &&
	t1.verbalunit == t2.verbalunit &&
	t1.node1 == t2.node1 &&
	lc1rel1 == lc2rel1 &&
	t1.node2 == t2.node2 &&
	lc1rel2 == lc2rel2
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




"""Compose delimited-text representation of a `VerbalUnitAnnotation`.
$(SIGNATURES)
"""
function delimited(tkn::TokenAnnotation; delimiter = "|")
	string(
		tkn.urn, delimiter,
		tkn.tokentype,delimiter,
		tkn.text,delimiter,
		tkn.verbalunit,delimiter,
		tkn.node1,delimiter,
		tkn.node1relation,delimiter,
		tkn.node2,delimiter,
		tkn.node2relation
		)
end


"""Compose delimited-text representation of a Vector of `VerbalUnitAnnotation`s.
$(SIGNATURES)
"""
function delimited(tknlist::Vector{TokenAnnotation}; delimiter = "|")
	hdr = "urn$(delimiter)tokentype$(delimiter)text$(delimiter)verbalunit$(delimiter)node1$(delimiter)node1relation$(delimiter)node2$(delimiter)node2relation\n"
	hdr * join(map(tkn -> delimited(tkn), tknlist), "\n") * "\n"
end

#=
urn::CtsUrn
	tokentype
	text
	verbalunit
	node1
	node1relation
	node2
	node2relation
=#