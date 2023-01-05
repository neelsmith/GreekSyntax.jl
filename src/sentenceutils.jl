"""Find CTS URN for range of tokens in `orthotokens`
where `orthotokens` is a vector of analyzed tokens as produced
by `Orthography`'s `tokenize` function.
"""
function sentencerange(orthotokens)
	baseurn = droppassage(orthotokens[1][1].urn)
	opener = passagecomponent(orthotokens[1][1].urn)
	closer = passagecomponent(orthotokens[end][1].urn)
	addpassage(baseurn, string(opener, "-", closer))
end


"""Find CTS URN for range of tokens in `tokenlist`
where `tokenlist` is a vector of annotated tokens.
"""
function sentencerange(tokenlist::Vector{TokenAnnotation})
	baseurn = droppassage(tokenlist[1].urn)
	opener = passagecomponent(tokenlist[1].urn)
	closer = passagecomponent(tokenlist[end].urn)
	addpassage(baseurn, string(opener, "-", closer))
end


"""Extract from a vector of `TokenAnnotation`s all the tokens that
belong to sentence `sa`.
$(SIGNATURES)
"""
function tokeninfoforsentence(sa::SentenceAnnotation, tknannotations::Vector{TokenAnnotation})
	# Find indices for tokens indexed to this sentence:
	tkncorp = map(tknannotations) do t
		CitablePassage(t.urn, t.text)
	end |> CitableTextCorpus
	slice = CitableCorpus.indexurn(sa.range, tkncorp)
	if isempty(slice)
		@error("Couldn't slice empty array for $(sa.range)")
	end
	@debug("Slicing $(slice)")
	origin = slice[1]

	connectorslice = CitableCorpus.indexurn(sa.connector, tkncorp)
	connectorids = isempty(connectorslice) ?  [] : connectorslice[1]:connectorslice[end]
	(tknannotations[origin:slice[2]], connectorids, origin)
end

"""Extract from a vector of `VerbalUnitAnnotation`s all the verbal units that belong to sentence `sa`.
$(SIGNATURES)
"""
function groupsforsentence(sa::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation})
	filter(vu -> vu.sentence == sa.range, groups)
end