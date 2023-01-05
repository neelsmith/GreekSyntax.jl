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