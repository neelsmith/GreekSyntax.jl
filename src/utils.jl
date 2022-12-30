"""Find CTS URN for range of tokens in sentence `s`
where `s` is a vector of analyzed tokens as produced
by `Orthography`'s `tokenize` function.
"""
function sentencerange(s)
	baseurn = droppassage(s[1][1].urn)
	opener = passagecomponent(s[1][1].urn)
	closer = passagecomponent(s[end][1].urn)
	addpassage(baseurn, string(opener, "-", closer))
end

"""Compose a string value for type of token, for use in
writing delimited-text representation of annotations.
"""
function typelabel(tkntype)
	if string(typeof(tkntype)) == "Orthography.LexicalToken"
		"lexical"
	elseif string(typeof(tkntype)) == "Orthography.PunctuationToken"
		"punctuation"
	elseif string(typeof(tkntype)) == "Orthography.UnanalyzedToken"
		"unanalyzed"
	else
		"unrecognized"
	end
end

function tokensforsentence(sa::SentenceAnnotation, tknannotations::Vector{TokenAnnotation})

	# Find indices for tokens indexed to this sentence:
	tkncorp = map(tknannotations) do t
		CitablePassage(t.urn, t.text)
	end |> CitableTextCorpus
	slice = CitableCorpus.indexurn(sa.range, tkncorp)
	origin = slice[1]

	connectorslice = CitableCorpus.indexurn(sa.connector, tkncorp)
	connectorids = connectorslice[1]:connectorslice[end]
	(tknannotations[origin:slice[2]], connectorids, origin)
end
